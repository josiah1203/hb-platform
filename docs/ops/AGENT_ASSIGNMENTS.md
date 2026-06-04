# HummingBird v8 — wave 1 agent assignments

Active parallel agents for Phase 0 / M1 scaffolding. Canonical workstream table: [`AGENTS.md`](../../AGENTS.md).

## Wave 1 (running)

| Agent ID | Subagent | Target repo | Worktree path | Branch (worktree) | Verify (from `hb-platform`) |
|----------|----------|-------------|---------------|-------------------|-------------------------------|
| **format** | `hcp-engineer` | [`hnf`](https://github.com/josiah1203/hnf) | `/Users/josiah/Desktop/hb-v8-format` | `feat/hb-v8-format-worktree` | `make hb-verify-format` |
| **hos** | `hcp-backend` | [`hbp-cloud`](https://github.com/josiah1203/hbp-cloud) (private) | `/Users/josiah/Desktop/hb-v8-hos` | `feat/hb-v8-hos-worktree` | `make hb-verify-hos` |
| **bridge** | `hcp-parser` | [`hb-bridge`](https://github.com/josiah1203/hb-bridge) | `/Users/josiah/Desktop/hb-v8-bridge` | `feat/hb-v8-bridge-worktree` | `make hb-verify-bridge` |

### Mapping (repo ownership)

- **format → hnf** — spec v0.1, `hnf-core`, `schemas/domains`
- **hos → hbp-cloud** — HOS, semantic merge, object store / API services
- **bridge → hb-bridge** — KiCad/FreeCAD plugins, roundtrip CI

### Bootstrap commands (already run)

```bash
cd /Users/josiah/Desktop/hb-platform
./scripts/hb-worktree.sh create format
./scripts/hb-worktree.sh create bridge
./scripts/hb-worktree.sh create hos
```

### Parallel verify (one host)

```bash
cd /Users/josiah/Desktop/hb-platform
make hb-verify-parallel   # format, bridge, hos, cli
```

**Constraint:** one `docker compose` integration stack per machine (ports 5433/6380/9002 or project `hbp-dev`).

## Not assigned in wave 1

`collab`, `hbw`, `workflow`, `cli`, `platform`, `registry`, `ai-local`, `devrel`, `coordinator`, `security` — create worktrees with `./scripts/hb-worktree.sh create <id>` when starting those agents.

## Related polyrepos (pushed, no wave-1 worktree)

| Repo | URL |
|------|-----|
| hb-platform | https://github.com/josiah1203/hb-platform |
| hbw | https://github.com/josiah1203/hbw |
| hb | https://github.com/josiah1203/hb |
| hbp-protocol | https://github.com/josiah1203/hbp-protocol |

Push details: [`PUSH_STATUS.md`](PUSH_STATUS.md).
