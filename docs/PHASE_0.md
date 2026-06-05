# Phase 0 gate checklist (Week 0–20)

Last updated: 2026-06-05 (Phase 0 exit)

| Gate | Owner | Deliverable | Status | Verify |
|------|-------|-------------|--------|--------|
| M0 spec | format | `hnf/spec/spec-v0.1.md` + schemas | **PASS** | `make hb-verify-format` |
| M0 legal | security | GPL/LGPL bridge boundary review | **PASS** | [`SECURITY_CHECKLIST.md`](./SECURITY_CHECKLIST.md) |
| M0 CRDT spike | collab + coordinator | ADR-0001 Accepted | **PASS** | [`ADR/0001-crdt-store.md`](./ADR/0001-crdt-store.md) |
| M1 HOS | hos | `hbp-cloud` HOS API + semantic merge | **PASS** | `make hb-verify-hos` |
| M1 bridges | bridge | KiCad + FreeCAD in-progress + host roundtrip | **PASS** | `make hb-verify-bridge` |
| M2 matrix | bridge | 13 Phase 0 tools harness-only+ | **PASS** | [`hb-bridge/plugins/README.md`](https://github.com/hummingbird-labs/hb-bridge/blob/main/plugins/README.md) |
| M2 workflow | workflow | 10 built-in checks + API | **PASS** | `make hb-verify-workflow` |
| M2 CLI | cli | `hb` auth, hnf, workflow, config | **PASS** | `make hb-verify-cli` |
| M2 HBW | hbw | repo list + commit DAG + diff | **PASS** | `make hb-verify-hbw` |
| M3 merge | hos | semantic merge v0.1 | **PASS** | `test_semantic_merge.py` |
| M3 workflow→HOS | workflow | CheckArtifact persisted as HOS commit | **PASS** | `test_workflow_api.py::test_run_workflow_persists_hos_commit` |
| M3 HBW | hbw | Automation / Review / Collab / Research + ai-local | **PASS** | `make hb-verify-hbw`, `make hb-verify-ai-local` |
| M3 packaging | hbw | Tauri macOS CI artifact | **PASS** | [`hbw/.github/workflows/ci.yml`](https://github.com/hummingbird-labs/hbw/blob/main/.github/workflows/ci.yml) |
| M3 demo | coordinator | Week 20 integration path | **PASS** | `./scripts/integration_demo.sh` |

Exit checklist: [`PHASE_0_EXIT.md`](./PHASE_0_EXIT.md)

Verify all: `make hb-verify-parallel hb-verify-collab hb-verify-workflow hb-verify-hbw hb-verify-ai-local hb-verify-gates` from `hb-platform`.
