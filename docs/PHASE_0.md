# Phase 0 gate checklist (Week 0–20)

| Gate | Owner | Deliverable |
|------|-------|-------------|
| M0 spec | format | `hnf/spec/spec-v0.1.md` + schemas |
| M0 legal | security | GPL/LGPL bridge boundary review |
| M0 CRDT spike | collab + coordinator | Automerge-rs vs Diamond Types decision |
| M1 HOS | hos | `hbp-cloud` HOS API ported; merge flag |
| M1 bridges | bridge | KiCad + FreeCAD roundtrip green |
| M2 matrix | bridge | Phase 0 tools harness (see `hb-bridge/plugins/README.md`) |
| M2 workflow | workflow | `packages/workflow` v0.1 |
| M2 CLI | cli | `hb` auth + `hb hnf` |
| M2 HBW | hbw | repo list + commit DAG shell |
| M3 merge | hos | semantic merge v0.1 |
| M3 HBW | hbw | Automation Studio v0.1 stub |
| M3 demo | coordinator | Bridge → HOS → workflow → HBW |

Verify: `make hb-verify-parallel` from `hb-platform`.
