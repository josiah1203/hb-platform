#!/usr/bin/env bash
# Week 20 integration demo — roundtrip → commit → workflow → HBW artifact path.
#
# API tiers (prefer local-first):
#   M4-local (default):  cd ../hbp-cloud && ./scripts/dev-local.sh
#   M4-prod (optional):  cd ../hbp-cloud && docker compose up -d
#
# Offline steps always run; live HOS steps run when API at HBP_API_URL is healthy.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DESKTOP="$(cd "$ROOT/.." && pwd)"
FIXTURE="${ROOT}/fixtures/minimal_schematic.hnf.json"
API_URL="${HBP_API_URL:-http://localhost:8000}"

echo "=== Week 20 integration demo (M3) ==="

# --- Phase 1: offline bridge + HNF validate ---
echo "-- Step 1: headless KiCad roundtrip"
if [[ -x "${DESKTOP}/hb-bridge/scripts/headless-roundtrip.sh" ]]; then
  "${DESKTOP}/hb-bridge/scripts/headless-roundtrip.sh"
else
  echo "SKIP: headless-roundtrip.sh missing"
fi

echo "-- Step 2: hb hnf validate (fixture)"
if [[ -f "$FIXTURE" && -d "${DESKTOP}/hb" ]]; then
  (cd "${DESKTOP}/hb" && python3 -m hb.main hnf validate "$FIXTURE" --json)
else
  echo "SKIP: fixture or hb CLI missing"
fi

# --- Phase 2: live stack ---
if ! curl -sf "${API_URL}/health/live" >/dev/null 2>&1; then
  echo "SKIP live path: API not reachable at ${API_URL}"
  echo "  M4-local (recommended): cd ${DESKTOP}/hbp-cloud && ./scripts/dev-local.sh"
  echo "  M4-prod (optional):     cd ${DESKTOP}/hbp-cloud && docker compose up -d"
  echo "  HBW UI:                 cd ${DESKTOP}/hbw && cp .env.local.example .env.local && npm run dev"
  echo "ok: integration demo (offline path complete)"
  exit 0
fi

echo "-- Step 3: auth + project bootstrap"
if [[ "${HBP_USE_LOCAL_SEED:-}" == "1" ]]; then
  EMAIL="${HBP_DEMO_EMAIL:-admin@dev.hbp}"
  PASSWORD="${HBP_DEMO_PASSWORD:-devpassword}"
  echo "Using local seed credentials (${EMAIL})"
else
  EMAIL="${HBP_DEMO_EMAIL:-demo-$(date +%s)@hb.local}"
  PASSWORD="${HBP_DEMO_PASSWORD:-demopass123}"
  ORG="${HBP_DEMO_ORG:-demo-org-$(date +%s)}"

  REGISTER_RESP="$(curl -sf -X POST "${API_URL}/v1/orgs/register" \
    -H "Content-Type: application/json" \
    -d "{\"org_name\":\"${ORG}\",\"email\":\"${EMAIL}\",\"password\":\"${PASSWORD}\",\"name\":\"Demo User\"}" 2>/dev/null || true)"

  if [[ -z "$REGISTER_RESP" ]]; then
    echo "WARN: org register failed — try HBP_USE_LOCAL_SEED=1 or HBP_ACCESS_TOKEN"
  fi
fi

LOGIN_RESP="$(curl -sf -X POST "${API_URL}/v1/auth/login" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASSWORD}\"}" 2>/dev/null || true)"

TOKEN="${HBP_ACCESS_TOKEN:-}"
if [[ -n "$LOGIN_RESP" ]]; then
  TOKEN="$(echo "$LOGIN_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('access_token',''))" 2>/dev/null || true)"
fi

if [[ -z "$TOKEN" ]]; then
  echo "FAIL: no access token — set HBP_ACCESS_TOKEN, HBP_USE_LOCAL_SEED=1, or fix register/login" >&2
  exit 1
fi

AUTH=(-H "Authorization: Bearer ${TOKEN}" -H "Content-Type: application/json")

PROJECT_RESP="$(curl -sf -X POST "${API_URL}/v1/projects" "${AUTH[@]}" \
  -d '{"name":"Week20 Demo","description":"M3 integration demo"}')"
PROJECT_ID="$(echo "$PROJECT_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")"
echo "Project: ${PROJECT_ID}"

echo "-- Step 4: HOS branch + commit (HNF tree)"
BRANCH_RESP="$(curl -sf -X POST "${API_URL}/v1/hos/branches" "${AUTH[@]}" \
  -d "{\"project_id\":\"${PROJECT_ID}\",\"name\":\"main\"}")"
BRANCH_ID="$(echo "$BRANCH_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")"

TREE_JSON="$(python3 -c "import json; print(json.dumps({'schematic.hnf': {'hnf_type': 'hardware.object', 'version_num': 1}}))")"
COMMIT_RESP="$(curl -sf -X POST "${API_URL}/v1/hos/commits" "${AUTH[@]}" \
  -d "{\"project_id\":\"${PROJECT_ID}\",\"branch_id\":\"${BRANCH_ID}\",\"message\":\"Week20 demo commit\",\"tree\":${TREE_JSON}}")"
COMMIT_ID="$(echo "$COMMIT_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")"
echo "Commit: ${COMMIT_ID}"

echo "-- Step 5: trigger DRC workflow → HOS artifact commit"
RUN_RESP="$(curl -sf -X POST "${API_URL}/v1/projects/${PROJECT_ID}/workflow/run" "${AUTH[@]}" \
  -d '{"check_id":"drc.kicad","trigger":"manual","context":{"domains":["layout"]}}')"
RUN_ID="$(echo "$RUN_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin)['run']['run_id'])")"
HOS_COMMIT="$(echo "$RUN_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin)['run'].get('hos_commit_id') or '')")"
STATUS="$(echo "$RUN_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin)['run']['status'])")"

if [[ -z "$HOS_COMMIT" ]]; then
  echo "FAIL: workflow run missing hos_commit_id" >&2
  exit 1
fi
echo "Workflow run ${RUN_ID}: ${STATUS} → HOS commit ${HOS_COMMIT}"

echo "-- Step 6: verify workflow branch snapshots (HBW artifact path)"
SNAP_RESP="$(curl -sf "${API_URL}/v1/hos/commits/${HOS_COMMIT}/snapshots?project_id=${PROJECT_ID}" \
  -H "Authorization: Bearer ${TOKEN}")"
echo "$SNAP_RESP" | python3 -c "
import sys, json
data = json.load(sys.stdin).get('data', [])
paths = {r.get('object_path') for r in data}
assert any(p and p.startswith('workflow/artifacts/') for p in paths), paths
assert any(p and p.startswith('workflow/runs/') for p in paths), paths
print('ok: workflow artifacts in HOS')
"

echo "-- Step 7: HBW workflow list (API parity)"
LIST_RESP="$(curl -sf "${API_URL}/v1/projects/${PROJECT_ID}/workflow/runs" \
  -H "Authorization: Bearer ${TOKEN}")"
echo "$LIST_RESP" | python3 -c "
import sys, json
runs = json.load(sys.stdin).get('data', [])
assert any(r.get('run_id') for r in runs), 'no runs listed'
print(f'ok: HBW can list {len(runs)} workflow run(s)')
"

if [[ -d "${DESKTOP}/hb" ]]; then
  echo "-- Step 8: hb workflow list (CLI)"
  HBP_API_URL="$API_URL" HBP_ACCESS_TOKEN="$TOKEN" \
    (cd "${DESKTOP}/hb" && python3 -m hb.main workflow list --project-id "$PROJECT_ID" --json) >/dev/null
  echo "ok: hb workflow list"
fi

echo "ok: Week 20 integration demo complete"
echo "HBW live UI: cd ${DESKTOP}/hbw && cp .env.local.example .env.local  # set VITE_HBP_ACCESS_TOKEN"
echo "             npm run dev  # http://localhost:5173 — see docs/ops/integration_smoke.md"
