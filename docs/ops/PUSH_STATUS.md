# HummingBird v8 — GitHub push status

Updated: 2026-06-04 (Phase 1 + Wave 2 merge complete)

## GitHub auth

- **Status:** OK — logged in as `josiah1203` (`gh auth status`)
- **Owner:** `josiah1203` (`HBP_GH_ORG` unset)
- **Protocol:** SSH (`git@github.com:...`)

## All merges pushed to `main`

| Repo | Visibility | Remote URL | `main` tip | Merged branches |
|------|------------|------------|------------|-----------------|
| hb-platform | public | https://github.com/josiah1203/hb-platform | Phase 2c ops + legal stubs | `feat/hb-v8-platform-ops-docs`, `feat/hb-v8-platform-infra` |
| hnf | public | https://github.com/josiah1203/hnf | format M1 | `feat/hb-v8-format-m1` |
| hb-bridge | public | https://github.com/josiah1203/hb-bridge | Phase 0 tool matrix | `feat/hb-v8-bridge-m1`, `feat/hb-v8-bridge-phase0-matrix` |
| hbp-cloud | **private** | https://github.com/josiah1203/hbp-cloud | hos + workflow + collab + infra | `feat/hb-v8-hos-semantic-merge`, `feat/hb-v8-workflow-engine`, `feat/hb-v8-collab-crdt`, `feat/hb-v8-platform-infra` |
| hbw | public | https://github.com/josiah1203/hbw | alpha shell | `feat/hb-v8-hbw-alpha-shell` |
| hb | public | https://github.com/josiah1203/hb | CLI M2 | `feat/hb-v8-cli-m2` |
| hbp-protocol | public | https://github.com/josiah1203/hbp-protocol | scaffold | — |

All default branches set to **`main`**.

## Verify status (post-merge)

```bash
cd /Users/josiah/Desktop/hb-platform
make hb-verify-parallel   # PASS — hnf 17, hb-bridge 22+, hbp-cloud 27 pytest, hb CLI 1
make hb-verify-gates      # PASS — docs + cargo + hbp-cloud 18 pytest
```

## Worktrees (optional — canonical repos are source of truth)

| Workstream | Worktree path | Owning repo | Notes |
|------------|---------------|-------------|-------|
| format | `/Users/josiah/Desktop/hb-v8-format` | `hnf` | Merged; safe to remove |
| bridge | `/Users/josiah/Desktop/hb-v8-bridge` | `hb-bridge` | Phase 0 matrix merged at `674540a` |
| hos | `/Users/josiah/Desktop/hb-v8-hos` | `hbp-cloud` | Merged; safe to remove |

## Wave 3 follow-ups

- **M3 integration alpha:** `hb CLI → HOS upload → HBW repo/diff view`
- **Phase 0.5 external gates:** collab soak evidence, restore drill log, OSS v0.1.0-alpha releases
- Legal/billing stubs now in `docs/legal/` (TOS, privacy, billing)
