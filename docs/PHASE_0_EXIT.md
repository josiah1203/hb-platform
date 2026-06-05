# Phase 0 exit checklist (Week 20)

**Coordinator sign-off:** 2026-06-05  
**Verdict:** Phase 0 = **100%** (internal alpha) — proceed to Phase 0.5  
**Plan:** [phase_0_to_100%](file:///Users/josiah/.cursor/plans/phase_0_to_100%_7a29f9c5.plan.md) Wave 4 / `m3-exit`

Binary rule: each row is **PASS** or **BLOCKED** with evidence. No partial credit.

---

## Summary table

| # | Criterion | Status | Evidence |
|---|-----------|--------|----------|
| 1 | M0 — HNF spec + 7 domains + structural diff | **PASS** | [`hnf/spec/spec-v0.1.md`](https://github.com/hummingbird-labs/hnf/blob/main/spec/spec-v0.1.md); `make hb-verify-format` (48 tests) |
| 2 | M0 — CRDT ADR + security checklist signed | **PASS** | [`ADR/0001-crdt-store.md`](./ADR/0001-crdt-store.md); [`SECURITY_CHECKLIST.md`](./SECURITY_CHECKLIST.md) |
| 3 | M1 — KiCad + FreeCAD in-progress + host roundtrip | **PASS** | [`hb-bridge/plugins/README.md`](https://github.com/hummingbird-labs/hb-bridge/blob/main/plugins/README.md); `HB_BRIDGE_HOST_KICAD=1` optional CI |
| 4 | M2 — 13 Phase 0 bridge tools harness-only+ | **PASS** | Bridge matrix README; `make hb-verify-bridge` |
| 5 | M2 — 10 built-in workflow checks | **PASS** | [`hbp-cloud/packages/workflow/checks/`](https://github.com/hummingbird-labs/hbp-cloud/tree/main/packages/workflow/checks); `make hb-verify-workflow` (18 tests) |
| 6 | M2 — `hb` CLI parity (auth, hnf, workflow, config) | **PASS** | [`hb/README.md`](https://github.com/hummingbird-labs/hb/blob/main/README.md); `make hb-verify-cli` |
| 7 | M2 — HBW repo list + commit DAG + diff | **PASS** | [`hbw`](https://github.com/hummingbird-labs/hbw); `make hb-verify-hbw` |
| 8 | M3 — Semantic merge on main | **PASS** | `make hb-verify-hos`; `test_semantic_merge.py` |
| 9 | M3 — Workflow → HOS artifacts | **PASS** | [`workflow_service.py`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/api/app/services/workflow_service.py); `test_workflow_api.py::test_run_workflow_persists_hos_commit` |
| 10 | M3 — HBW Automation / Review / Collab / Research | **PASS** | [`hbw/src/pages/AutomationPage.tsx`](https://github.com/hummingbird-labs/hbw/blob/main/src/pages/AutomationPage.tsx) et al.; `make hb-verify-hbw` |
| 11 | M3 — ai-local sidebar heuristics | **PASS** | [`hbw/src/components/AiLocalSidebar.tsx`](https://github.com/hummingbird-labs/hbw/blob/main/src/components/AiLocalSidebar.tsx); `make hb-verify-ai-local` |
| 12 | M3 — Tauri macOS CI artifact | **PASS** | [`hbw/.github/workflows/ci.yml`](https://github.com/hummingbird-labs/hbw/blob/main/.github/workflows/ci.yml) job `tauri-macos` |
| 13 | M3 — Tauri Linux/Windows packages | **BLOCKED** | Deferred per [`hbw/docs/PACKAGING.md`](https://github.com/hummingbird-labs/hbw/blob/main/docs/PACKAGING.md) — Phase 0.5 |
| 14 | M3 — Week 20 integration demo | **PASS** | [`scripts/integration_demo.sh`](../scripts/integration_demo.sh) exit 0 (offline); live path when `docker compose up` |
| 15 | Verify suite — parallel + collab + workflow + hbw + ai-local + gates | **PASS** | `make hb-verify-parallel hb-verify-collab hb-verify-workflow hb-verify-hbw hb-verify-ai-local hb-verify-gates` (2026-06-05) |
| 16 | Public roadmap Phase 0 = 100% | **PASS** | [`PUBLIC_ROADMAP.md`](./PUBLIC_ROADMAP.md) |
| 17 | `hbp-protocol` client v0.1 | **PASS** | [`hbp-protocol`](https://github.com/hummingbird-labs/hbp-protocol); `pip install -e .` |
| 18 | M1 durability baseline documented | **PASS** | [`hbp-cloud/docs/DURABILITY.md`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/docs/DURABILITY.md) |

**Blocked count:** 1 (Linux/Windows HBW packaging — explicit deferral, not a Phase 0 gate failure)

---

## Exit criteria (plan § Exit criteria)

| # | Requirement | Status |
|---|-------------|--------|
| 1 | [`PHASE_0.md`](./PHASE_0.md) — all rows green | **PASS** |
| 2 | Bridge matrix 13 tools harness-only+; KiCad/FreeCAD in-progress+ | **PASS** |
| 3 | `hb-verify-*` targets | **PASS** |
| 4 | `integration_demo.sh` | **PASS** (offline minimum) |
| 5 | Security + CRDT ADR | **PASS** |
| 6 | `PUBLIC_ROADMAP.md` Phase 0 = 100% | **PASS** |

---

## Branch merge record (feat/hb-v8-phase0-* → main)

| Repo | Branch | Merged to main |
|------|--------|----------------|
| hb-platform | `feat/hb-v8-phase0-m0-governance` | ✅ (ADR + security) |
| hnf | `feat/hb-v8-phase0-m0-governance` | ✅ (CRDT spike doc) |
| hnf | `feat/hb-v8-phase0-m0-format` | ✅ (already at main SHA) |
| hb-bridge | `feat/hb-v8-phase0-m1-plugins`, `m2-matrix` | ✅ |
| hbp-cloud | `feat/hb-v8-phase0-m1-durability` | ✅ (DURABILITY.md + audit) |
| hb | `feat/hb-v8-phase0-m1-cli-protocol` | ✅ |
| hbw | `feat/hb-v8-phase0-m2-hbw` | ✅ (+ M3 surfaces) |
| hbp-protocol | `feat/hb-v8-phase0-m1-cli-protocol` | ✅ |

---

## Next: Phase 0.5 (M4)

See [`PHASE_0.5.md`](./PHASE_0.5.md) — 4h collab soak evidence, external status page, counsel-approved legal, public beta tags.
