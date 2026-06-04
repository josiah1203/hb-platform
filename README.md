# hb-platform — HummingBird v8 meta coordination

This repository does **not** ship product code. It coordinates the v8 **polyrepo** program:

| Repo | License | Role |
|------|---------|------|
| [hnf](../hnf) | Apache 2.0 | HNF spec + `hnf-core` Rust lib |
| [hb-bridge](../hb-bridge) | Apache 2.0 | In-tool plugins + roundtrip CI |
| [hbw](../hbw) | Apache 2.0 | Tauri command center (HBW) |
| [hb](../hb) | Apache 2.0 | `hb` CLI |
| [hbp-protocol](../hbp-protocol) | Apache 2.0 | HOS JSON-RPC + event taxonomy |
| [hbp-cloud](../hbp-cloud) | Proprietary | HBP API, HOS, workflow, deploy |

**Archive:** HCP is frozen at tag `phase-0.5-beta-rc1` — do not edit [`HCP_working`](../HCP_working) for v8 work.

## Agents

See [`AGENTS.md`](AGENTS.md) for workstream IDs, copy-paste Cursor prompts, and verify targets.

```bash
make hb-verify-parallel   # safe subset
./scripts/hb-worktree.sh create format
./scripts/import-from-hcp.sh   # idempotent graft refresh
```

Docs: [`docs/ENGINEERING_PLAN_v8.md`](docs/ENGINEERING_PLAN_v8.md) · [`docs/REUSE_FROM_HCP.md`](docs/REUSE_FROM_HCP.md)
