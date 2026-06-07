#!/usr/bin/env bash
# Phase 0.5 M4-local gate orchestrator: API → soak → restore → import loss.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DESKTOP="$(cd "$ROOT/.." && pwd)"
CLOUD="$DESKTOP/hbp-cloud"
BRIDGE="$DESKTOP/hb-bridge"
API_URL="${HBP_API_URL:-http://127.0.0.1:8000}"
PROJECT_ID="${HBP_PROJECT_ID:-c8af677b-a4b1-465b-861e-61042f999078}"
EMAIL="${HBP_EMAIL:-admin@dev.hbp}"
PASSWORD="${HBP_PASSWORD:-devpassword}"
SOAK_JSON="$ROOT/docs/ops/collaboration_soak_local.json"
RESTORE_MD="$ROOT/docs/ops/restore_drill_local.md"
IMPORT_JSON="$ROOT/docs/ops/import_loss_local.json"
IMPORT_MD="$ROOT/docs/ops/import_loss_local.md"
PIDFILE="$CLOUD/.local/uvicorn.pid"

stop_api() {
  if [[ -f "$PIDFILE" ]]; then
    local pid
    pid="$(cat "$PIDFILE")"
    if kill -0 "$pid" 2>/dev/null; then
      echo "Stopping API (PID $pid)"
      kill "$pid" 2>/dev/null || true
      sleep 1
    fi
    rm -f "$PIDFILE"
  fi
}

cleanup() {
  stop_api
}
trap cleanup EXIT

echo "=== Phase 0.5 local gate orchestrator ==="
echo "hb-platform: $ROOT"
echo "hbp-cloud:   $CLOUD"
echo "hb-bridge:   $BRIDGE"

echo ""
echo "-- Step 1: start local API"
stop_api
"$CLOUD/scripts/dev-local.sh"

echo ""
echo "-- Step 2: resolve project id from seed (fallback to env)"
SEED_OUT="$(cd "$CLOUD" && PYTHONPATH="$CLOUD:$CLOUD/api" python3 "$CLOUD/scripts/seed_dev.py" 2>&1 || true)"
if echo "$SEED_OUT" | grep -q 'HBP_PROJECT_ID='; then
  PROJECT_ID="$(echo "$SEED_OUT" | grep 'HBP_PROJECT_ID=' | tail -1 | cut -d= -f2)"
fi
echo "Using HBP_PROJECT_ID=$PROJECT_ID"

echo ""
echo "-- Step 3: collaboration soak (120 iterations)"
export HBP_API_URL="$API_URL"
export HBP_PROJECT_ID="$PROJECT_ID"
export HBP_EMAIL="$EMAIL"
export HBP_PASSWORD="$PASSWORD"
python3 "$CLOUD/scripts/collaboration_soak.py" \
  --iterations 120 \
  --interval-s 1 \
  --tier local \
  --gate m4_local_collab_soak \
  --log-file "$SOAK_JSON"

echo ""
echo "-- Step 4: local restore drill"
export HBP_EVIDENCE_MD="$RESTORE_MD"
"$CLOUD/scripts/local_restore_drill.sh"

echo ""
echo "-- Step 5: import loss report (headless corpus)"
python3 "$BRIDGE/scripts/import_loss_report.py" \
  --tier local \
  --gate m4_local_import_loss \
  --json-out "$IMPORT_JSON" \
  --md-out "$IMPORT_MD"

echo ""
echo "-- Step 6: verify evidence"
python3 - "$ROOT" <<'PY'
import json
import sys
from pathlib import Path

root = Path(sys.argv[1])
soak = json.loads((root / "docs/ops/collaboration_soak_local.json").read_text())
if not soak.get("passed"):
    print("FAIL: collaboration soak passed=false", file=sys.stderr)
    sys.exit(1)
loss = json.loads((root / "docs/ops/import_loss_local.json").read_text())
if not loss.get("passed") or loss.get("aggregate_loss_ratio", 1) >= 0.05:
    print("FAIL: import loss gate", file=sys.stderr)
    sys.exit(1)
restore = (root / "docs/ops/restore_drill_local.md").read_text()
if "**Tier** | local |" not in restore:
    print("FAIL: restore drill missing local tier evidence", file=sys.stderr)
    sys.exit(1)
if "**Result** | **PASS** |" not in restore.split("Local tier run")[-1]:
    print("FAIL: restore drill latest local run not PASS", file=sys.stderr)
    sys.exit(1)
print("Evidence verification OK")
PY

echo ""
echo "=== Phase 0.5 local gates PASS ==="
exit 0
