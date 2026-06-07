# M3 integration alpha smoke

End-to-end path for Phase 0 alpha: **hb CLI → HNF validate → hb-bridge roundtrip → HOS commit → workflow artifact → HBW**.

## Local quickstart (M4-local, no Docker)

Fast path for Phase 0.5 local gates — SQLite + in-process CRDT via `dev-local.sh`:

```bash
# 1. Start local API (seeds admin@dev.hbp / devpassword + Sample Project)
cd ../hbp-cloud && ./scripts/dev-local.sh
curl -sf http://localhost:8000/health/live && echo ok

# 2. Offline + live integration demo (from hb-platform)
cd ../hb-platform
chmod +x scripts/integration_demo.sh
./scripts/integration_demo.sh

# Optional: reuse seeded dev user instead of registering a demo org
HBP_USE_LOCAL_SEED=1 ./scripts/integration_demo.sh
```

**Docker (M4-prod, optional):** `cd ../hbp-cloud && docker compose up -d` — same demo script; use when validating compose/kind gates.

### HBW against local API

```bash
# Token (hb CLI)
cd ../hb
python3 -m hb.main auth login \
  --api-url http://localhost:8000 \
  --email admin@dev.hbp \
  --password devpassword \
  --json
# Copy access_token into hbw/.env.local

cd ../hbw
cp .env.local.example .env.local
# Edit .env.local: set VITE_HBP_ACCESS_TOKEN=<token from login>
npm run dev   # http://localhost:5173
```

Without `VITE_HBP_API_URL` + token, HBW falls back to mock data in `src/data/mock.ts`.

### HBW live verify (Phase 0.5 local exit gate #10)

Manual checklist after `dev-local.sh` + `.env.local` — confirms live API wiring (not mocks):

| Route | Verify |
|-------|--------|
| `#/repositories` | Header shows **(live API)**; lists seeded **Sample Project** (or demo project from `integration_demo.sh`) |
| `#/automation` | Lists workflow runs; trigger DRC shows live status (not mock banner) |
| `#/collab` | Presence panel connects to `/v1/collaboration/presence` without mock fallback |

Cross-ref: [`PHASE_0.5_LOCAL_EXIT.md`](../PHASE_0.5_LOCAL_EXIT.md) row **HBW live path** (documented here; signed when manual verify passes).

## Offline smoke (no API)

From `hb-platform`:

```bash
chmod +x scripts/integration_smoke.sh scripts/integration_demo.sh scripts/verify-ai-local.sh
./scripts/integration_smoke.sh
```

Or step-by-step:

```bash
# 1. Validate HNF fixture
cd ../hb
python3 -m hb.main hnf validate ../hb-platform/fixtures/minimal_schematic.hnf.json --json

# 2. Headless KiCad roundtrip (hb-bridge)
../hb-bridge/scripts/headless-roundtrip.sh
```

Expected: exit code `0`, `"valid": true` from validate, `ok: headless roundtrip` from bridge.

## Week 20 integration demo (M3)

Full path with live stack:

```bash
# M4-local (recommended)
cd ../hbp-cloud && ./scripts/dev-local.sh
cd ../hb-platform
./scripts/integration_demo.sh

# M4-prod (optional)
cd ../hbp-cloud && docker compose up -d
cd ../hb-platform
./scripts/integration_demo.sh
```

Steps executed when API is healthy:

1. Headless KiCad roundtrip + HNF validate (offline)
2. Register/login (or `HBP_ACCESS_TOKEN` / `HBP_USE_LOCAL_SEED=1`)
3. Create project → `main` branch → HOS commit
4. `POST /v1/projects/{id}/workflow/run` (DRC) → `hos_commit_id`
5. Verify workflow snapshots on HOS commit
6. List runs (HBW / CLI parity)

Offline-only: demo exits `0` after steps 1–2 if API is down.

## Live HOS path (optional)

```bash
export HBP_API_URL=http://localhost:8000
export HBP_ACCESS_TOKEN=$(cd ../hb && python3 -m hb.main auth login \
  --api-url http://localhost:8000 \
  --email admin@dev.hbp --password devpassword --json \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])")
export HBP_PROJECT_ID=<project-uuid>

# List repos (CLI)
hb repo list --json

# Workflow run + HOS artifact
hb workflow run --check drc.kicad --project-id "$HBP_PROJECT_ID" --json
```

See also: [`kicad_hos_smoke.sh`](../../scripts/kicad_hos_smoke.sh).

## HBW M3 surfaces

| Route | Surface |
|-------|---------|
| `/automation` | Automation Studio — list built-ins, trigger run, show status |
| `/review` | Comment thread shell on head commit |
| `/collab` | CRDT presence (`/v1/collaboration/presence`) |
| `/research` | URL + note capture stub |
| Sidebar `ai-local` | BOM sync, EOL placeholder, cross-domain heuristics |

```bash
cp ../hbw/.env.local.example ../hbw/.env.local
# set VITE_HBP_ACCESS_TOKEN
cd ../hbw && npm run dev
```

## Verify targets

```bash
cd /Users/josiah/Desktop/hb-platform
make hb-verify-parallel
make hb-verify-workflow
make hb-verify-hbw
make hb-verify-ai-local
make hb-verify-collab
make hb-verify-platform
./scripts/integration_demo.sh
```
