# HummingBird Labs v8 — parallel agents

Canonical plan: [`docs/ENGINEERING_PLAN_v8.md`](docs/ENGINEERING_PLAN_v8.md). **Do not edit** the HCP archive ([`HCP_working`](../HCP_working)); graft via [`scripts/import-from-hcp.sh`](scripts/import-from-hcp.sh).

## Before starting a v8 agent

```bash
cd /path/to/hb-platform
./scripts/hb-worktree.sh create <workstream>
cd ../hb-v8-<workstream>
git checkout -b feat/hb-v8-<workstream>-<short-desc>
```

## Workstreams

| ID | Subagent | Owns (repo) | Verify |
|----|----------|-------------|--------|
| `format` | `hcp-engineer` | `hnf/` — spec, `hnf-core`, domain schemas | `make hb-verify-format` |
| `bridge` | `hcp-parser` | `hb-bridge/` — plugins, roundtrip CI | `make hb-verify-bridge` |
| `hos` | `hcp-backend` | `hbp-cloud/` — HOS, semantic merge, object store | `make hb-verify-hos` |
| `collab` | `hcp-engineer` | `hbp-cloud/` — CRDT (replace collaboration stub) | `make hb-verify-collab` |
| `hbw` | `hcp-frontend` | `hbw/` — Tauri command center | `make hb-verify-hbw` |
| `workflow` | `hcp-engineer` | `hbp-cloud/` — trigger→condition→action | `make hb-verify-workflow` |
| `cli` | `hcp-engineer` | `hb/` — `hb` CLI + `hbp-protocol` | `make hb-verify-cli` |
| `platform` | `hcp-infra` | `hbp-cloud/` deploy, Helm/kind, CI | `make hb-verify-platform` |
| `registry` | `hcp-engineer` | `hbp-cloud/` — private component registry (P1) | `make hb-verify-registry` |
| `ai-local` | `hcp-engineer` | `hbw/` + `hbp-cloud/` — Tier-1 local automations | `make hb-verify-ai-local` |
| `security` | `hcp-tech-lead` | Review only: GPL boundary, CRDT auth, sandbox | checklist |
| `devrel` | `hcp-engineer` | `hb-platform/docs`, public roadmap | `make hb-verify-devrel` |
| `coordinator` | `hcp-tech-lead` | Phase gates, ADRs — no implementation | `make hb-verify-gates` |

```bash
make hb-verify-parallel   # format, bridge, hos, cli — one host
```

**Rule:** one `docker compose` integration stack per machine (ports 5433/6380/9002 or project `hbp-dev`).

## Agent prompts (copy into Task / subagent)

### format

```
Work in hnf/ only. Spec v0.1, hnf-core Rust lib, schemas/domains for Phase 0 + Phase 1 stubs.
Do not break grafted HOS validation contracts in hbp-cloud without coordinating hos agent.
Run: make hb-verify-format (from hb-platform)
Branch: feat/hb-v8-format-<desc>
```

### bridge

```
Work in hb-bridge/ only. KiCad/FreeCAD v0.1 plugins; roundtrip CI; plugins/README matrix.
v8: upstream plugins, not long-lived forks. Run: make hb-verify-bridge
Branch: feat/hb-v8-bridge-<desc>
```

### hos

```
Work in hbp-cloud/api HOS services. Semantic merge v0.1; HOS_MERGE_ENGINE=legacy|semantic flag.
Run: make hb-verify-hos
Branch: feat/hb-v8-hos-<desc>
```

### collab

```
Replace CRDT stub in hbp-cloud collaboration service. 4h soak gate for 0.5.
Run: make hb-verify-collab
Branch: feat/hb-v8-collab-<desc>
```

### hbw

```
Work in hbw/ Tauri app. Phase 0 alpha: repo list, commit DAG, diff shell — no CAD authoring.
Run: make hb-verify-hbw
Branch: feat/hb-v8-hbw-<desc>
```

### workflow

```
hbp-cloud workflow engine v0.1 + packages/workflow. Wire DRC/ERC/BOM as first actions.
Run: make hb-verify-workflow
Branch: feat/hb-v8-workflow-<desc>
```

### cli

```
Work in hb/ and hbp-protocol/. hb commands; HBP_* env vars; publish client SDK later.
Run: make hb-verify-cli
Branch: feat/hb-v8-cli-<desc>
```

### platform

```
hbp-cloud infra: pal, helm, kind, restore drill, CI. 0.5 durability gates.
Run: make hb-verify-platform
Branch: feat/hb-v8-platform-<desc>
```

### registry

```
Private component registry (Phase 1 Week 36). Run: make hb-verify-registry
Branch: feat/hb-v8-registry-<desc>
```

### ai-local

```
HBW sidebar + cloud hooks for local automations only (no HB AI cloud at 0.5).
Run: make hb-verify-ai-local
Branch: feat/hb-v8-ai-local-<desc>
```

### devrel

```
hb-platform/docs: PUBLIC_ROADMAP, phase gates, HB Commons stubs.
Run: make hb-verify-devrel
Branch: feat/hb-v8-devrel-<desc>
```

### coordinator

```
Read-only phase gates and ADRs. make hb-verify-gates. No product code.
```

## Deprecated (do not spin by default)

HCP V5 `fork`, V2 default `parser/graph` tracks — optional `hbp-cloud/legacy-ingest/` only for upload migration.
