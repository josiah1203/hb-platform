# HummingBird v8 — GitHub push status

Updated: 2026-06-04 (Phase 1 merge complete)

## GitHub auth

- **Status:** OK — logged in as `josiah1203` (`gh auth status`)
- **Owner:** `josiah1203` (`HBP_GH_ORG` unset)
- **Protocol:** SSH (`git@github.com:...`)

## M1/M2 merges pushed to `main`

| Repo | Visibility | Remote URL | `main` tip | Merged branches |
|------|------------|------------|------------|-----------------|
| hb-platform | public | https://github.com/josiah1203/hb-platform | ops docs + gates fix | `feat/hb-v8-platform-ops-docs` |
| hnf | public | https://github.com/josiah1203/hnf | format M1 | `feat/hb-v8-format-m1` |
| hb-bridge | public | https://github.com/josiah1203/hb-bridge | bridge M1 | `feat/hb-v8-bridge-m1` |
| hbp-cloud | **private** | https://github.com/josiah1203/hbp-cloud | hos + workflow | `feat/hb-v8-hos-semantic-merge`, `feat/hb-v8-workflow-engine` |
| hbw | public | https://github.com/josiah1203/hbw | alpha shell | `feat/hb-v8-hbw-alpha-shell` |
| hb | public | https://github.com/josiah1203/hb | CLI M2 | `feat/hb-v8-cli-m2` |
| hbp-protocol | public | https://github.com/josiah1203/hbp-protocol | scaffold | — |

All default branches set to **`main`** (including `hb-bridge`, previously `feat/hb-v8-bridge-m1`).

## Verify status (post-merge)

```bash
cd /Users/josiah/Desktop/hb-platform
make hb-verify-parallel   # PASS
make hb-verify-gates      # PASS (isolated CARGO_TARGET_DIR in phase05-gates.sh)
```

## Worktrees (wave 1 — still present)

| Workstream | Worktree path | Owning repo | Notes |
|------------|---------------|-------------|-------|
| format | `/Users/josiah/Desktop/hb-v8-format` | `hnf` | Optional; canonical `hnf/` is source of truth |
| bridge | `/Users/josiah/Desktop/hb-v8-bridge` | `hb-bridge` | Optional; gates skip worktree paths |
| hos | `/Users/josiah/Desktop/hb-v8-hos` | `hbp-cloud` | Optional; semantic merge now on `main` |

## Wave 2 follow-ups

- Launch **collab**, **bridge matrix**, and **platform/infra** agents (see [`AGENT_ASSIGNMENTS.md`](AGENT_ASSIGNMENTS.md)).
- Run Phase 0.5 external gates (collab soak, restore drill, OSS v0.1.0-alpha releases).
