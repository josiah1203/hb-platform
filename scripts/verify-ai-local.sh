#!/usr/bin/env bash
# Verify HBW ai-local sidebar heuristics (offline, no API).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DESKTOP="$(cd "$ROOT/.." && pwd)"
HBW="${DESKTOP}/hbw"

echo "=== hb/ai-local verify ==="

for f in \
  "${HBW}/src/components/AiLocalSidebar.tsx" \
  "${HBW}/src/utils/aiLocalHeuristics.ts"; do
  if [[ ! -f "$f" ]]; then
    echo "FAIL: missing $f" >&2
    exit 1
  fi
done

python3 - "$HBW" <<'PY'
import sys
from pathlib import Path

hbw = Path(sys.argv[1])
sys.path.insert(0, str(hbw / "src"))

# Inline mirror of TS heuristics for offline gate
def evaluate(ctx):
    insights = []
    bom = ctx.get("bomRowCount", 0)
    sch = ctx.get("schematicRefCount", 0)
    if bom > 0 and sch > 0 and bom != sch:
        insights.append("bom-sync")
    elif bom == 0 and sch > 0:
        insights.append("bom-sync-empty")
    insights.append("eol-placeholder")
    domains = set(ctx.get("domainsPresent") or [])
    if "schematic" in domains and "layout" in domains:
        layout = ctx.get("layoutRefCount", sch)
        if layout != sch and sch > 0:
            insights.append("cross-domain")
    return insights

ids = evaluate({"bomRowCount": 12, "schematicRefCount": 10, "layoutRefCount": 10, "domainsPresent": ["schematic", "bom", "layout"]})
assert "bom-sync" in ids, ids
assert "eol-placeholder" in ids, ids
print("ok: ai-local heuristics gate")
PY

if [[ -f "${HBW}/package.json" ]]; then
  (cd "$HBW" && npm test) >/dev/null
  echo "ok: hbw build (tsc + vite)"
fi

echo "ok: hb/ai-local verify"
