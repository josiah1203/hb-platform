#!/usr/bin/env bash
# Git worktrees for parallel v8 subagents (one branch/build per workstream).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DESKTOP="$(dirname "$ROOT")"
VALID_IDS=(format bridge hos collab hbw workflow cli platform registry ai-local devrel security coordinator)

usage() {
  cat <<'EOF'
Usage:
  scripts/hb-worktree.sh create <workstream>
  scripts/hb-worktree.sh list
  scripts/hb-worktree.sh remove <workstream>

Workstreams: format bridge hos collab hbw workflow cli platform registry ai-local devrel security coordinator

Creates ../hb-v8-<workstream> as a linked worktree on the owning repo.
Branch: feat/hb-v8-<workstream>-worktree
EOF
}

valid_id() {
  local id="$1"
  for v in "${VALID_IDS[@]}"; do
    [[ "$v" == "$id" ]] && return 0
  done
  return 1
}

repo_for() {
  case "$1" in
    format) echo "$DESKTOP/hnf" ;;
    bridge) echo "$DESKTOP/hb-bridge" ;;
    hos|collab|workflow|registry) echo "$DESKTOP/hbp-cloud" ;;
    platform) echo "$DESKTOP/hbp-cloud" ;;
    hbw|ai-local) echo "$DESKTOP/hbw" ;;
    cli) echo "$DESKTOP/hb" ;;
    devrel|coordinator|security) echo "$ROOT" ;;
    *) return 1 ;;
  esac
}

cmd="${1:-}"
id="${2:-}"

case "$cmd" in
  create)
    if [[ -z "$id" ]] || ! valid_id "$id"; then
      echo "error: workstream must be one of: ${VALID_IDS[*]}" >&2
      exit 1
    fi
    repo="$(repo_for "$id")"
    if [[ ! -d "$repo/.git" ]]; then
      echo "error: repo missing (init first): $repo" >&2
      exit 1
    fi
    dest="$DESKTOP/hb-v8-${id}"
    branch="feat/hb-v8-${id}-worktree"
    if [[ -d "$dest" ]]; then
      echo "worktree already exists: $dest"
      exit 0
    fi
    cd "$repo"
    if git rev-parse --verify "$branch" >/dev/null 2>&1; then
      git worktree add "$dest" "$branch"
    else
      git worktree add -b "$branch" "$dest" HEAD
    fi
    echo "Created $dest on branch $branch (repo: $repo)"
    echo "Verify: cd $ROOT && make hb-verify-${id}"
    ;;
  list)
    for r in "$DESKTOP"/hnf "$DESKTOP"/hb-bridge "$DESKTOP"/hbp-cloud "$DESKTOP"/hbw "$DESKTOP"/hb "$ROOT"; do
      [[ -d "$r/.git" ]] && git -C "$r" worktree list
    done
    ;;
  remove)
    if [[ -z "$id" ]] || ! valid_id "$id"; then
      echo "error: workstream must be one of: ${VALID_IDS[*]}" >&2
      exit 1
    fi
    repo="$(repo_for "$id")"
    dest="$DESKTOP/hb-v8-${id}"
    cd "$repo"
    if [[ -d "$dest" ]]; then
      git worktree remove "$dest" --force 2>/dev/null || git worktree remove "$dest"
      echo "Removed worktree $dest"
    else
      echo "No worktree at $dest"
    fi
    ;;
  ""|-h|--help|help)
    usage
    ;;
  *)
    echo "error: unknown command $cmd" >&2
    usage
    exit 1
    ;;
esac
