# HummingBird v8 — GitHub push status

Generated: 2026-06-04 (UTC)

## GitHub auth

- **Status:** OK — logged in as `josiah1203` (`gh auth status`)
- **Owner:** `josiah1203` (`HBP_GH_ORG` unset; used `gh api user -q .login`)
- **Protocol:** SSH (`git@github.com:...`)

If push fails in CI or on another machine, run: `gh auth login`

## Initial commits

Each repo under `/Users/josiah/Desktop` received root commit `chore: v8 scaffold` where the tree was previously empty. Repos with parallel M1 work may also have feature branches on GitHub (see below).

## Remote URLs and push results

| Repo | Visibility | Remote URL | Push | Notes |
|------|------------|------------|------|-------|
| hb-platform | public | https://github.com/josiah1203/hb-platform | **OK** | `main` → `origin/main` |
| hnf | public | https://github.com/josiah1203/hnf | **OK** | `main` + `feat/hb-v8-format-m1` |
| hb-bridge | public | https://github.com/josiah1203/hb-bridge | **OK** | `main` + `feat/hb-v8-bridge-m1` (GitHub default branch: `feat/hb-v8-bridge-m1`) |
| hbw | public | https://github.com/josiah1203/hbw | **OK** | `main` |
| hb | public | https://github.com/josiah1203/hb | **OK** | `main` |
| hbp-protocol | public | https://github.com/josiah1203/hbp-protocol | **OK** | `main` |
| hbp-cloud | **private** | https://github.com/josiah1203/hbp-cloud | **OK** | `main` + `feat/hb-v8-hos-m1` |

All seven repositories were created (or updated) via `gh repo create … --source=. --remote=origin --push` with `hbp-cloud` using `--private`.

## Worktrees (wave 1)

Created from `hb-platform` via `./scripts/hb-worktree.sh`:

| Workstream | Worktree path | Owning repo | Branch |
|------------|---------------|-------------|--------|
| format | `/Users/josiah/Desktop/hb-v8-format` | `hnf` | `feat/hb-v8-format-worktree` |
| bridge | `/Users/josiah/Desktop/hb-v8-bridge` | `hb-bridge` | `feat/hb-v8-bridge-worktree` |
| hos | `/Users/josiah/Desktop/hb-v8-hos` | `hbp-cloud` | `feat/hb-v8-hos-worktree` |

Verify from platform root: `cd /Users/josiah/Desktop/hb-platform && make hb-verify-<workstream>`.

## Follow-ups

- Consider aligning GitHub **default branch** on `hb-bridge` to `main` if M1 feature branch should not be default.
- Push `docs/ops/*` updates from this doc run: commit in `hb-platform` when ready.
