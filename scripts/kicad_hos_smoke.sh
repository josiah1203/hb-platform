#!/usr/bin/env bash
# KiCad roundtrip → HOS commit path (M3 alpha).
# Offline: runs headless KiCad adapter roundtrip.
# Online: optional import via hb CLI when HBP_API_URL + token are set.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DESKTOP="$(cd "$ROOT/.." && pwd)"
BRIDGE="${DESKTOP}/hb-bridge"

echo "=== KiCad → HOS smoke ==="

echo "-- Step 1: headless KiCad roundtrip (hb-bridge)"
if [[ -d "$BRIDGE" ]]; then
  (cd "$BRIDGE" && cargo test -p hnf-kicad -p roundtrip-harness -q)
  if [[ -x "$BRIDGE/scripts/headless-roundtrip.sh" ]]; then
    "$BRIDGE/scripts/headless-roundtrip.sh"
  fi
else
  echo "SKIP: hb-bridge not found"
fi

echo "-- Step 2: validate exported HNF snapshot"
FIXTURE="${ROOT}/fixtures/minimal_schematic.hnf.json"
if [[ -f "$FIXTURE" && -d "$DESKTOP/hb" ]]; then
  (cd "$DESKTOP/hb" && python3 -m hb.main hnf validate "$FIXTURE" --json)
fi

echo "-- Step 3: HOS import (optional — requires live API)"
if [[ -n "${HBP_API_URL:-}" && -n "${HBP_ACCESS_TOKEN:-${HBP_API_KEY:-}}" && -n "${HBP_PROJECT_ID:-}" ]]; then
  CORPUS="${BRIDGE}/corpora/kicad/manifest.json"
  if [[ -f "$CORPUS" ]]; then
    echo "Using corpus manifest: $CORPUS"
  fi
  if [[ -d "$DESKTOP/hb" ]]; then
    echo "Run manually when a .kicad_sch or zip is available:"
    echo "  hb import --project-id \$HBP_PROJECT_ID --format kicad --file <path> --message 'KiCad roundtrip smoke'"
    echo "  hb commit create --project-id \$HBP_PROJECT_ID --branch-id <branch> --message 'HNF snapshot' --tree-json '{...}'"
  fi
else
  echo "SKIP: set HBP_API_URL, HBP_ACCESS_TOKEN, HBP_PROJECT_ID for live HOS import"
fi

echo "ok: KiCad → HOS smoke (offline path complete)"
