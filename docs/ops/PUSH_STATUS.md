# HummingBird v8 — GitHub push status

Updated: 2026-06-05 (Wave 2 merge + M3/M4 evidence)

## GitHub auth

- **Status:** OK — logged in as `josiah1203` (`gh auth status`)
- **Owner:** `josiah1203` (`HBP_GH_ORG` unset)
- **Protocol:** SSH (`git@github.com:...`)

## Wave 2 merges pushed to `main`

| Repo | Visibility | `main` tip | Merged branches |
|------|------------|------------|-----------------|
| hb-platform | public | M3 smoke + M4 evidence | `feat/hb-v8-platform-infra` (prior), M3/M4 ops commit |
| hnf | public | format M1 | `feat/hb-v8-format-m1` (wave 1) |
| hb-bridge | public | Phase 0 tool matrix | `feat/hb-v8-bridge-phase0-matrix` |
| hbp-cloud | **private** | collab + platform infra | `feat/hb-v8-platform-infra`, `feat/hb-v8-collab-crdt` |
| hbw | public | HOS API client | `feat/hb-v8-hbw-alpha-shell` + M3 client |
| hb | public | CLI M2 | `feat/hb-v8-cli-m2` (wave 1) |
| hbp-protocol | public | scaffold | — |

All default branches: **`main`**.

## OSS tags (v0.1.0-alpha)

| Repo | Tag | Notes |
|------|-----|-------|
| hnf | `v0.1.0-alpha` | format M1 |
| hb-bridge | `v0.1.0-alpha` | M1 + Phase 0 matrix |
| hbw | `v0.1.0-alpha` | alpha shell + HOS client |
| hb | `v0.1.0-alpha` | CLI M2 |

## Verify status (post Wave 2)

```bash
cd /Users/josiah/Desktop/hb-platform
make hb-verify-parallel   # PASS
make hb-verify-gates      # PASS
make hb-verify-collab     # PASS
make hb-verify-platform   # PASS
./scripts/integration_smoke.sh  # PASS (offline)
```

## Worktrees (wave 1 — still present)

| Workstream | Worktree path | Owning repo | Notes |
|------------|---------------|-------------|-------|
| format | `/Users/josiah/Desktop/hb-v8-format` | `hnf` | Optional; canonical `hnf/` is source of truth |
| bridge | `/Users/josiah/Desktop/hb-v8-bridge` | `hb-bridge` | Optional; gates skip worktree paths |
| hos | `/Users/josiah/Desktop/hb-v8-hos` | `hbp-cloud` | Optional; semantic merge now on `main` |

## Phase 0.5 evidence (stubs)

- [`docs/ops/collaboration_soak_local.json`](collaboration_soak_local.json) — template with run instructions
- [`docs/ops/restore_drill_local.md`](restore_drill_local.md) — dry-run output captured
- [`docs/ops/integration_smoke.md`](integration_smoke.md) — M3 end-to-end smoke path
- [`docs/legal/`](../legal/) — TOS, privacy, billing stubs

## Next steps

- Run live 4h collab soak and full restore drill (replace evidence stubs with PASS)
- GitHub releases from v0.1.0-alpha tags
- Phase 1 parallel workstreams (workflow + hbw composer, format + bridge registry)
