#!/usr/bin/env bash
# M3 integration alpha — minimal offline smoke (no API required).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DESKTOP="$(cd "$ROOT/.." && pwd)"
FIXTURE="${ROOT}/fixtures/minimal_schematic.hnf.json"

echo "=== M3 integration smoke (offline) ==="

if [[ ! -f "$FIXTURE" ]]; then
  echo "FAIL: missing fixture $FIXTURE" >&2
  exit 1
fi

echo "-- hb hnf validate (fixture)"
if [[ -d "$DESKTOP/hb" ]]; then
  (cd "$DESKTOP/hb" && python3 -m hb.main hnf validate "$FIXTURE" --json)
else
  echo "SKIP: ../hb not found"
fi

echo "-- hb-bridge headless roundtrip (KiCad stub)"
if [[ -x "$DESKTOP/hb-bridge/scripts/headless-roundtrip.sh" ]]; then
  "$DESKTOP/hb-bridge/scripts/headless-roundtrip.sh"
else
  echo "SKIP: hb-bridge headless-roundtrip.sh not found"
fi

echo "ok: integration smoke (offline subset)"
