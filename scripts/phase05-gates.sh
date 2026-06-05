#!/usr/bin/env bash
# Phase 0.5 gate checks (M4 stub) — run from hb-platform root.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DESKTOP="$(cd "$ROOT/.." && pwd)"
FAIL=0

pass() { echo "  OK  $*"; }
fail() { echo "  FAIL $*"; FAIL=1; }
skip() { echo "  SKIP $*"; }

echo "=== Phase 0.5 gate stub (hb-platform) ==="

# --- Required docs ---
echo ""
echo "-- Documentation --"
for doc in \
  "$ROOT/docs/PHASE_0.5.md" \
  "$ROOT/docs/PHASE_1.md" \
  "$ROOT/docs/PUBLIC_ROADMAP.md" \
  "$ROOT/docs/SECURITY_CHECKLIST.md"; do
  if [[ -f "$doc" ]]; then pass "$(basename "$doc")"; else fail "missing $doc"; fi
done

if [[ -f "$DESKTOP/hbp-cloud/scripts/collaboration_soak.py" ]]; then
  pass "hbp-cloud/scripts/collaboration_soak.py"
else
  fail "hbp-cloud/scripts/collaboration_soak.py (collab soak reference)"
fi

# --- Rust: hnf + hb-bridge (canonical checkouts only; isolated target dirs) ---
cargo_test_canonical() {
  local repo="$1"
  local label="$2"
  if [[ ! -f "$DESKTOP/$repo/Cargo.toml" ]]; then
    skip "$label not found"
    return 0
  fi
  local target_dir="$DESKTOP/$repo/target/gates"
  if (cd "$DESKTOP/$repo" && CARGO_TARGET_DIR="$target_dir" cargo test -q); then
    pass "$label cargo test"
  else
    fail "$label cargo test"
  fi
}

echo ""
echo "-- cargo test (hnf, hb-bridge) --"
cargo_test_canonical "hnf" "hnf"
cargo_test_canonical "hb-bridge" "hb-bridge"

# --- Python: hbp-cloud HOS subset ---
echo ""
echo "-- pytest hbp-cloud (hos/hnf/collab subset) --"
if [[ -d "$DESKTOP/hbp-cloud/api/tests" ]]; then
  if (cd "$DESKTOP/hbp-cloud/api" && \
      PYTHONPATH="$DESKTOP/hbp-cloud:$DESKTOP/hbp-cloud/api:$DESKTOP/hbp-cloud/graph" \
      python3 -m pytest tests/test_hos_version_control.py tests/test_hnf.py tests/test_collaboration.py -q --tb=line 2>/dev/null); then
    pass "hbp-cloud pytest subset"
  else
    skip "hbp-cloud pytest (deps unavailable — pip install -r requirements-dev.txt)"
  fi
else
  skip "hbp-cloud/api/tests not found"
fi

# --- Checklist from PHASE_0.5.md ---
echo ""
echo "-- Phase 0.5 checklist (from docs/PHASE_0.5.md) --"
grep -E '^\| [^|]' "$ROOT/docs/PHASE_0.5.md" | grep -v '^| Gate' | grep -v '^|---' || true

echo ""
if [[ "$FAIL" -eq 0 ]]; then
  echo "hb/gates: stub passed (docs + unit tests; full gates require M4 evidence)"
  exit 0
else
  echo "hb/gates: stub failed — fix items above"
  exit 1
fi
