# HummingBird v8 — agent assignments

Canonical workstream table: [`AGENTS.md`](../../AGENTS.md).

## Wave 1 (merged to main — 2026-06-04)

| Workstream | Repo | Branch merged | Verify (from `hb-platform`) |
|------------|------|---------------|-------------------------------|
| **format** | [`hnf`](https://github.com/josiah1203/hnf) | `feat/hb-v8-format-m1` | `make hb-verify-format` |
| **bridge** | [`hb-bridge`](https://github.com/josiah1203/hb-bridge) | `feat/hb-v8-bridge-m1` | `make hb-verify-bridge` |
| **hos** | [`hbp-cloud`](https://github.com/josiah1203/hbp-cloud) (private) | `feat/hb-v8-hos-semantic-merge` | `make hb-verify-hos` |
| **workflow** | [`hbp-cloud`](https://github.com/josiah1203/hbp-cloud) (private) | `feat/hb-v8-workflow-engine` | `make hb-verify-workflow` |
| **hbw** | [`hbw`](https://github.com/josiah1203/hbw) | `feat/hb-v8-hbw-alpha-shell` | `make hb-verify-hbw` |
| **cli** | [`hb`](https://github.com/josiah1203/hb) | `feat/hb-v8-cli-m2` | `make hb-verify-cli` |

Wave 1 worktrees (`hb-v8-format`, `hb-v8-bridge`, `hb-v8-hos`) remain for parallel development but **gates and CI use canonical repo paths only** (`scripts/phase05-gates.sh` sets isolated `CARGO_TARGET_DIR`).

## Wave 2 (merged to main — 2026-06-05)

| Agent ID | Subagent | Repo | Branch merged | Verify |
|----------|----------|------|---------------|--------|
| **collab** | `hcp-backend` | `hbp-cloud` | `feat/hb-v8-collab-crdt` | `make hb-verify-collab` |
| **bridge** | `hcp-parser` | `hb-bridge` | `feat/hb-v8-bridge-phase0-matrix` | `make hb-verify-bridge` |
| **platform** | `hcp-infra` | `hb-platform` + `hbp-cloud` | `feat/hb-v8-platform-infra` | `make hb-verify-platform` |

## M3 integration alpha (2026-06-05)

| Deliverable | Location | Status |
|-------------|----------|--------|
| Offline smoke | `scripts/integration_smoke.sh`, [`docs/ops/integration_smoke.md`](integration_smoke.md) | PASS |
| HBW HOS client | `hbw/src/api/hosClient.ts` | env-configured fetch + mock fallback |
| KiCad → HOS path | `scripts/kicad_hos_smoke.sh` | offline roundtrip + live import docs |

## Phase 0.5 gates (M4 — evidence stubs)

| Gate | Evidence file | Status |
|------|---------------|--------|
| Collab soak | [`collaboration_soak_local.json`](collaboration_soak_local.json) | template + run instructions |
| Restore drill | [`restore_drill_local.md`](restore_drill_local.md) | dry-run captured |
| OSS v0.1.0-alpha | tags on hnf, hb-bridge, hbw, hb | pushed |
| Legal/billing | [`docs/legal/`](../legal/) | linked from `PHASE_0.5.md` |

### Parallel verify (one host)

```bash
cd /Users/josiah/Desktop/hb-platform
make hb-verify-parallel   # format, bridge, hos, cli
make hb-verify-gates      # Phase 0.5 stub (docs + unit tests)
make hb-verify-collab
make hb-verify-platform
```

**Constraint:** one `docker compose` integration stack per machine (ports 5433/6380/9002 or project `hbp-dev`).

## Not yet assigned

`registry`, `ai-local`, `devrel`, `coordinator`, `security` — create worktrees with `./scripts/hb-worktree.sh create <id>` when starting those agents.

## Related polyrepos

| Repo | URL | Default branch |
|------|-----|----------------|
| hb-platform | https://github.com/josiah1203/hb-platform | `main` |
| hnf | https://github.com/josiah1203/hnf | `main` |
| hb-bridge | https://github.com/josiah1203/hb-bridge | `main` |
| hbp-cloud | https://github.com/josiah1203/hbp-cloud (private) | `main` |
| hbw | https://github.com/josiah1203/hbw | `main` |
| hb | https://github.com/josiah1203/hb | `main` |
| hbp-protocol | https://github.com/josiah1203/hbp-protocol | `main` |

Push details: [`PUSH_STATUS.md`](PUSH_STATUS.md).
