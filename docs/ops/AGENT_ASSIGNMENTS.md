# HummingBird v8 — agent assignments

Canonical workstream table: [`AGENTS.md`](../../AGENTS.md).

## Wave 1 (merged to main — 2026-06-04)

| Workstream | Repo | Branch merged | Verify (from `hb-platform`) |
|------------|------|---------------|-------------------------------|
| **format** | [`hnf`](https://github.com/josiah1203/hnf) | `feat/hb-v8-format-m1` | `make hb-verify-format` |
| **bridge** | [`hb-bridge`](https://github.com/josiah1203/hb-bridge) | `feat/hb-v8-bridge-m1`, `feat/hb-v8-bridge-phase0-matrix` | `make hb-verify-bridge` |
| **hos** | [`hbp-cloud`](https://github.com/josiah1203/hbp-cloud) (private) | `feat/hb-v8-hos-semantic-merge` | `make hb-verify-hos` |
| **workflow** | [`hbp-cloud`](https://github.com/josiah1203/hbp-cloud) (private) | `feat/hb-v8-workflow-engine` | `make hb-verify-workflow` |
| **hbw** | [`hbw`](https://github.com/josiah1203/hbw) | `feat/hb-v8-hbw-alpha-shell` | `make hb-verify-hbw` |
| **cli** | [`hb`](https://github.com/josiah1203/hb) | `feat/hb-v8-cli-m2` | `make hb-verify-cli` |

## Wave 2 (merged to main — 2026-06-04)

| Workstream | Repo | Branch merged | Verify |
|------------|------|---------------|--------|
| **collab** | [`hbp-cloud`](https://github.com/josiah1203/hbp-cloud) (private) | `feat/hb-v8-collab-crdt` | `make hb-verify-collab` |
| **platform** | [`hbp-cloud`](https://github.com/josiah1203/hbp-cloud) (private) | `feat/hb-v8-platform-infra` | `make hb-verify-platform` |
| **platform** | [`hb-platform`](https://github.com/josiah1203/hb-platform) | `feat/hb-v8-platform-infra` | `make hb-verify-gates` |

Wave 1 worktrees (`hb-v8-format`, `hb-v8-bridge`, `hb-v8-hos`) remain for parallel development but **gates and CI use canonical repo paths only** (`scripts/phase05-gates.sh` sets isolated `CARGO_TARGET_DIR`).

## Wave 3 (ready to launch)

| Agent ID | Subagent | Target repo | Focus | Verify |
|----------|----------|-------------|-------|--------|
| **integration** | `hcp-engineer` | `hb` + `hbp-cloud` + `hbw` | End-to-end smoke: CLI → HOS upload → HBW diff | manual |
| **gates** | `hcp-infra` | `hb-platform` | Collab soak evidence, restore drill log, OSS v0.1.0-alpha releases | `make hb-verify-gates` |
| **devrel** | — | `hb-platform` | Status page, public roadmap updates | `make hb-verify-devrel` |

### Parallel verify (one host)

```bash
cd /Users/josiah/Desktop/hb-platform
make hb-verify-parallel   # format, bridge, hos, cli
make hb-verify-gates      # Phase 0.5 stub (docs + unit tests)
make hb-verify-collab     # CRDT collaboration tests
make hb-verify-workflow   # workflow engine tests
```

**Constraint:** one `docker compose` integration stack per machine (ports 5433/6380/9002 or project `hbp-dev`).

## Not yet assigned

`registry`, `ai-local`, `coordinator`, `security` — create worktrees with `./scripts/hb-worktree.sh create <id>` when starting those agents.

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
