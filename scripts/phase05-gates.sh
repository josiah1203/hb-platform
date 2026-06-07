#!/usr/bin/env bash
# Phase 0.5 gate checks — run from hb-platform root.
# PHASE05_TIER=local (default) validates M4-local evidence JSON/MD.
# PHASE05_TIER=stub skips evidence validation (legacy doc + unit-test check).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DESKTOP="$(cd "$ROOT/.." && pwd)"
TIER="${PHASE05_TIER:-local}"
FAIL=0

pass() { echo "  OK  $*"; }
fail() { echo "  FAIL $*"; FAIL=1; }
skip() { echo "  SKIP $*"; }

echo "=== Phase 0.5 gates (hb-platform, tier=$TIER) ==="

# --- Required docs ---
echo ""
echo "-- Documentation --"
for doc in \
  "$ROOT/docs/PHASE_0.5.md" \
  "$ROOT/docs/PHASE_0.5_LOCAL_EXIT.md" \
  "$ROOT/docs/PHASE_0.5_PROD.md" \
  "$ROOT/docs/ADR/0003-m4-local-vs-prod-gates.md" \
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

# --- M4-local evidence validation ---
validate_local_evidence() {
  echo ""
  echo "-- M4-local evidence (JSON/MD) --"

  local soak_json="$ROOT/docs/ops/collaboration_soak_local.json"
  local import_json="$ROOT/docs/ops/import_loss_local.json"
  local import_md="$ROOT/docs/ops/import_loss_local.md"
  local restore_md="$ROOT/docs/ops/restore_drill_local.md"
  local status_html="$ROOT/docs/status/index.html"

  for f in "$soak_json" "$import_json" "$import_md" "$restore_md" "$status_html"; do
    if [[ -f "$f" ]]; then pass "$(basename "$f")"; else fail "missing $f"; fi
  done

  if [[ -f "$soak_json" ]]; then
    python3 - "$soak_json" <<'PY' || fail "collaboration_soak_local.json validation"
import json, sys
p = sys.argv[1]
d = json.load(open(p))
assert d.get("passed") is True, "passed must be true"
assert d.get("tier") == "local", "tier must be local"
assert d.get("gate") == "m4_local_collab_soak", "gate mismatch"
assert d.get("failures", 1) == 0, "failures must be 0"
print("  OK  soak JSON: passed=true tier=local failures=0")
PY
  fi

  if [[ -f "$import_json" ]]; then
    python3 - "$import_json" <<'PY' || fail "import_loss_local.json validation"
import json, sys
p = sys.argv[1]
d = json.load(open(p))
assert d.get("passed") is True, "passed must be true"
assert d.get("tier") == "local", "tier must be local"
loss = float(d.get("aggregate_loss_ratio", 1))
assert loss < 0.05, f"aggregate_loss_ratio {loss} >= 0.05"
print(f"  OK  import JSON: passed=true loss={loss:.2%}")
PY
  fi

  if [[ -f "$import_md" ]]; then
    if grep -q '0\.00%' "$import_md" && grep -q '\*\*PASS\*\*' "$import_md"; then
      pass "import_loss_local.md PASS + loss < 5%"
    else
      fail "import_loss_local.md missing PASS or loss evidence"
    fi
  fi

  if [[ -f "$restore_md" ]]; then
    if grep -q 'Local tier run' "$restore_md" && grep -q '\*\*Result\*\* | \*\*PASS\*\* |' "$restore_md"; then
      pass "restore_drill_local.md local tier PASS"
    else
      fail "restore_drill_local.md missing local tier PASS"
    fi
  fi

  if [[ -f "$status_html" ]]; then
    if grep -q 'M4-local' "$status_html" && grep -q 'localhost:8000' "$status_html"; then
      pass "status/index.html local tier markers"
    else
      fail "status/index.html missing local tier content"
    fi
  fi
}

if [[ "$TIER" == "local" ]]; then
  validate_local_evidence
elif [[ "$TIER" == "stub" ]]; then
  skip "M4-local evidence validation (PHASE05_TIER=stub)"
else
  fail "unknown PHASE05_TIER=$TIER (use local or stub)"
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

echo ""
if [[ "$FAIL" -eq 0 ]]; then
  if [[ "$TIER" == "local" ]]; then
    echo "hb/gates: M4-local passed (docs + evidence + unit tests)"
  else
    echo "hb/gates: stub passed (docs + unit tests)"
  fi
  exit 0
else
  echo "hb/gates: failed — fix items above"
  exit 1
fi
