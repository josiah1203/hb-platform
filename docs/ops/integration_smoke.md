# M3 integration alpha smoke

End-to-end path for Phase 0 alpha: **hb CLI → HNF validate → hb-bridge roundtrip → HOS commit → workflow artifact → HBW**.

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
cd ../hbp-cloud && docker compose up -d
cd ../hb-platform
./scripts/integration_demo.sh
```

Steps executed when API is healthy:

1. Headless KiCad roundtrip + HNF validate (offline)
2. Register/login (or `HBP_ACCESS_TOKEN`)
3. Create project → `main` branch → HOS commit
4. `POST /v1/projects/{id}/workflow/run` (DRC) → `hos_commit_id`
5. Verify workflow snapshots on HOS commit
6. List runs (HBW / CLI parity)

Offline-only: demo exits `0` after steps 1–2 if API is down.

## Live HOS path (optional)

```bash
export HBP_API_URL=http://localhost:8000
export HBP_ACCESS_TOKEN=$(hb auth login --email admin@dev.hbp --password devpassword --save 2>/dev/null | ...)
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
export VITE_HBP_API_URL=http://localhost:8000
export VITE_HBP_ACCESS_TOKEN=<token>
cd ../hbw && npm run dev
```

Without env vars, HBW falls back to mock data in `src/data/mock.ts`.

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
