# M3 integration alpha smoke

Minimal end-to-end path for Phase 0 alpha: **hb CLI → HNF validate → hb-bridge roundtrip → (optional) HOS import → HBW repo list**.

## Offline smoke (no API)

From `hb-platform`:

```bash
chmod +x scripts/integration_smoke.sh scripts/kicad_hos_smoke.sh
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

## Live HOS path (optional)

```bash
export HBP_API_URL=http://localhost:8000
export HBP_ACCESS_TOKEN=$(hb auth login --email admin@dev.hbp --password devpassword --save 2>/dev/null | ...)
export HBP_PROJECT_ID=<project-uuid>

# List repos (CLI)
hb repo list --json

# KiCad import → commit
hb import --project-id "$HBP_PROJECT_ID" --format kicad --file board.kicad_sch --message "M3 smoke"
```

See also: [`kicad_hos_smoke.sh`](../../scripts/kicad_hos_smoke.sh).

## HBW read-only repo list

HBW fetches `/v1/projects` when configured:

```bash
# Vite dev / Tauri
export VITE_HBP_API_URL=http://localhost:8000
export VITE_HBP_ACCESS_TOKEN=<token>
cd ../hbw && npm run dev
```

Without env vars, HBW falls back to mock data in `src/data/mock.ts`.

## Verify targets

```bash
cd /Users/josiah/Desktop/hb-platform
make hb-verify-parallel
make hb-verify-gates
make hb-verify-collab
make hb-verify-platform
```
