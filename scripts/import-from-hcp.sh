#!/usr/bin/env bash
# Idempotent graft from HCP archive into HummingBird v8 polyrepos.
set -euo pipefail

HCP_SRC="${HCP_SRC:-/Users/josiah/Desktop/HCP_working}"
DESKTOP="${DESKTOP:-/Users/josiah/Desktop}"
TAG="${HCP_TAG:-phase-0.5-beta-rc1}"
COMMIT="${HCP_COMMIT:-$(git -C "$HCP_SRC" rev-parse "$TAG" 2>/dev/null || git -C "$HCP_SRC" rev-parse main)}"

REUSE_BODY() {
  cat <<EOF
# Reuse from HCP (archive)

| Field | Value |
|-------|--------|
| **Tag** | \`${TAG}\` |
| **Commit** | \`${COMMIT}\` |
| **Source** | \`${HCP_SRC}\` |

Do not treat HCP as a live dependency — this repo was grafted once for v8 bootstrap.
Re-run \`hb-platform/scripts/import-from-hcp.sh\` only when intentionally refreshing from the archive.
EOF
}

init_repo() {
  local dir="$1"
  mkdir -p "$dir"
  if [[ ! -d "$dir/.git" ]]; then
    git -C "$dir" init -q
    git -C "$dir" branch -M main 2>/dev/null || true
  fi
}

RSYNC_EXCLUDES=(
  --exclude '__pycache__' --exclude '*.pyc' --exclude '.pytest_cache'
  --exclude 'target' --exclude 'node_modules' --exclude '.git'
  --exclude '.cursor' --exclude '.DS_Store' --exclude '.mypy_cache'
)

copy_tree() {
  local src="$1" dest="$2"
  if [[ ! -e "$src" ]]; then
    return 0
  fi
  if [[ -f "$src" ]]; then
    mkdir -p "$(dirname "$dest")"
    cp -f "$src" "$dest"
    return 0
  fi
  mkdir -p "$dest"
  rsync -a "${RSYNC_EXCLUDES[@]}" "$src/" "$dest/"
}

apache_license() {
  local dir="$1"
  if [[ ! -f "$dir/LICENSE" ]]; then
    curl -sfL https://www.apache.org/licenses/LICENSE-2.0.txt -o "$dir/LICENSE" 2>/dev/null || \
      cp "$HCP_SRC/adapters/LICENSE" "$dir/LICENSE" 2>/dev/null || true
  fi
  if [[ ! -f "$dir/LICENSE" ]]; then
    printf '%s\n' 'Apache License 2.0 — see https://www.apache.org/licenses/LICENSE-2.0' > "$dir/LICENSE"
  fi
}

proprietary_license() {
  local dir="$1"
  cat > "$dir/LICENSE" <<'EOF'
HummingBird Platform (hbp-cloud) — Proprietary

Copyright (c) HummingBird Labs. All rights reserved.
Unauthorized copying, distribution, or use is prohibited.
See README.md for OSS boundary (public repos: hnf, hb-bridge, hbw, hb, hbp-protocol).
EOF
}

echo "HCP graft: tag=$TAG commit=$COMMIT"

# --- hnf ---
HNF="$DESKTOP/hnf"
init_repo "$HNF"
apache_license "$HNF"
copy_tree "$HCP_SRC/adapters/crates/hnf-adapter-sdk/src" "$HNF/crates/hnf-core/src"
for f in README.md; do
  [[ -f "$HCP_SRC/adapters/crates/hnf-adapter-sdk/$f" ]] && cp "$HCP_SRC/adapters/crates/hnf-adapter-sdk/$f" "$HNF/crates/hnf-core/$f"
done
REUSE_BODY > "$HNF/REUSE_FROM_HCP.md"

# --- hb-bridge ---
BRIDGE="$DESKTOP/hb-bridge"
init_repo "$BRIDGE"
apache_license "$BRIDGE"
mkdir -p "$BRIDGE/crates"
for crate in hnf-kicad hnf-freecad; do
  copy_tree "$HCP_SRC/adapters/crates/$crate" "$BRIDGE/crates/$crate"
done
copy_tree "$HCP_SRC/rust/crates/sidecar-protocol/src" "$BRIDGE/crates/protocol/src"
cp "$HCP_SRC/rust/crates/sidecar-protocol/Cargo.toml" "$BRIDGE/crates/protocol/Cargo.toml"
copy_tree "$HCP_SRC/scripts/regression" "$BRIDGE/scripts/regression"
REUSE_BODY > "$BRIDGE/REUSE_FROM_HCP.md"

# --- hbp-protocol ---
PROTO="$DESKTOP/hbp-protocol"
init_repo "$PROTO"
apache_license "$PROTO"
mkdir -p "$PROTO/docs/protocol/jsonrpc" "$PROTO/hbp_protocol"
cp "$HCP_SRC/docs/protocol/jsonrpc/hcp-hos-client.v0.json" "$PROTO/docs/protocol/jsonrpc/hbp-hos-client.v0.json"
sed -i '' 's/hcp\.rpc\.v0/hbp.rpc.v0/g; s/hcp-hos/hbp-hos/g' "$PROTO/docs/protocol/jsonrpc/hbp-hos-client.v0.json" 2>/dev/null || \
  sed -i 's/hcp\.rpc\.v0/hbp.rpc.v0/g; s/hcp-hos/hbp-hos/g' "$PROTO/docs/protocol/jsonrpc/hbp-hos-client.v0.json"
cp "$HCP_SRC/api/app/services/event_taxonomy.py" "$PROTO/hbp_protocol/event_taxonomy.py"
touch "$PROTO/hbp_protocol/__init__.py"
REUSE_BODY > "$PROTO/REUSE_FROM_HCP.md"

# --- hb (CLI) ---
HB="$DESKTOP/hb"
init_repo "$HB"
apache_license "$HB"
mkdir -p "$HB/hb" "$HB/tests"
cp "$HCP_SRC/cli/pyproject.toml" "$HB/pyproject.toml"
cp "$HCP_SRC/cli/README.md" "$HB/README.md" 2>/dev/null || true
cp "$HCP_SRC/cli/hw/__init__.py" "$HB/hb/__init__.py"
cp "$HCP_SRC/cli/hw/main.py" "$HB/hb/main.py"
cp "$HCP_SRC/cli/tests/"* "$HB/tests/" 2>/dev/null || true
sed -i '' \
  -e 's/hw-cli/hb-cli/g' -e 's/"hw"/"hb"/g' -e 's/packages = \["hw"\]/packages = ["hb"]/g' \
  -e 's/HCP_/HBP_/g' -e 's/hcp\.io/hbp.io/g' -e 's/HCP /HBP /g' -e 's/prog="hw"/prog="hb"/g' \
  -e 's/from hw\./from hb./g' -e 's/`hw /`hb /g' \
  "$HB/pyproject.toml" "$HB/hb/main.py" "$HB/tests/"*.py 2>/dev/null || \
sed -i \
  -e 's/hw-cli/hb-cli/g' -e 's/"hw"/"hb"/g' -e 's/packages = \["hw"\]/packages = ["hb"]/g' \
  -e 's/HCP_/HBP_/g' -e 's/hcp\.io/hbp.io/g' -e 's/HCP /HBP /g' -e 's/prog="hw"/prog="hb"/g' \
  -e 's/from hw\./from hb./g' -e 's/`hw /`hb /g' \
  "$HB/pyproject.toml" "$HB/hb/main.py" "$HB/tests/"*.py
REUSE_BODY > "$HB/REUSE_FROM_HCP.md"

# --- hbp-cloud ---
CLOUD="$DESKTOP/hbp-cloud"
init_repo "$CLOUD"
proprietary_license "$CLOUD"
for path in api graph infra/pal infra/helm infra/kind; do
  if [[ -d "$HCP_SRC/$path" ]]; then
    copy_tree "$HCP_SRC/$path" "$CLOUD/$path"
  fi
done
# Optional legacy-ingest (upload/parse path); not Phase 0 critical
if [[ -d "$HCP_SRC/parser" ]]; then
  copy_tree "$HCP_SRC/parser" "$CLOUD/legacy-ingest/parser"
fi
for path in docker-compose.yml .env.example; do
  [[ -f "$HCP_SRC/$path" ]] && copy_tree "$HCP_SRC/$path" "$CLOUD/$path"
done
# Light rename hcp -> hbp in helm chart dirs (best-effort)
if [[ -d "$CLOUD/infra/helm" ]]; then
  find "$CLOUD/infra/helm" -type f \( -name '*.yaml' -o -name '*.yml' -o -name 'Chart.yaml' \) -print0 2>/dev/null | \
    while IFS= read -r -d '' f; do
      sed -i '' 's/hcp-api/hbp-api/g; s/hcp-platform/hbp-platform/g; s/HCP_/HBP_/g' "$f" 2>/dev/null || \
        sed -i 's/hcp-api/hbp-api/g; s/hcp-platform/hbp-platform/g; s/HCP_/HBP_/g' "$f"
    done
fi
REUSE_BODY > "$CLOUD/REUSE_FROM_HCP.md"

# --- hb-platform meta REUSE ---
PLATFORM="$DESKTOP/hb-platform"
init_repo "$PLATFORM"
REUSE_BODY > "$PLATFORM/docs/REUSE_FROM_HCP.md"

echo "Graft complete."
