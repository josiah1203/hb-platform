# HummingBird v8 — Program progress report

**Last updated:** 2026-06-06 · **Coordinator:** hb-platform

## Summary

| Phase | Milestone | Status | Verify |
|-------|-----------|--------|--------|
| **Phase 0** | M0–M3 internal alpha | **100%** | [`PHASE_0_EXIT.md`](PHASE_0_EXIT.md) |
| **Phase 0.5** | M4 beta-open gates | **~55%** | [`PHASE_0.5.md`](PHASE_0.5.md) — evidence templates; some gates BLOCKED |
| **Phase 1** | M5 workflow cloud + built env | **100%** | [`PHASE_1_EXIT.md`](PHASE_1_EXIT.md) |

## Phase 0 (complete)

- 7 HNF domains (Rust + JSON Schema + fixtures)
- 10 workflow built-in checks, HOS artifact persistence
- HBW Tauri alpha (Repos/History/Diff/Automation/Review/Collab/Research)
- `hb` CLI auth/validate/workflow
- HB Bridge Phase 0 plugins (KiCad, FreeCAD, …)
- ADR-0001 CRDT store decision

## Phase 0.5 (in progress — does not block Phase 1 code)

| Gate | Status | Evidence |
|------|--------|----------|
| 2-week stable alpha | BLOCKED | Release branch pending |
| Restore drill | PASS (script) | `hbp-cloud/infra/kind/restore-drill.sh` |
| 4h collab soak | BLOCKED | `collaboration_soak.py` — JSON evidence pending |
| Import <5% loss | PARTIAL | Corpus CI partial |
| Status page + IR | BLOCKED | Template in ops docs |
| ToS / privacy / billing | PASS (stub) | `docs/legal/` |
| Public OSS v0.1.0-alpha | BLOCKED | Tags pending |
| Public roadmap | PASS | `PUBLIC_ROADMAP.md` |

## Phase 1 (complete)

### Workstream A — Workflow cloud

| Deliverable | Repo | Tests |
|-------------|------|-------|
| Workflow composer UI | `hbw` | vite build |
| Marketplace API + UI | `hbp-cloud`, `hbw` | `test_marketplace.py` |
| Webhooks router | `hbp-cloud/webhooks` | `test_phase1_webhooks_billing.py` |
| Branch/sim/AI gates | `hbp-cloud/packages/workflow/engine/gates.py` | `test_workflow_engine.py` |
| Workflow-minute billing | `hbp-cloud/packages/billing` | metering tests |
| CI template | `hb-platform/docs/ci/` | doc |

### Workstream B — Built environment

| Deliverable | Repo | Tests |
|-------------|------|-------|
| 4 HNF domains | `hnf` | +27 fixture tests (79 total cargo) |
| ADR-0002 + mechanical superset | `hnf`, `hb-bridge` | mechanical + FreeCAD STEP ref |
| 10 bridge plugins | `hb-bridge/plugins/phase1` | 11 pytest |
| 3 workflow checks | `hbp-cloud` | 13 built-ins total |
| Private registry | `hbp-cloud/packages/registry` | `test_registry.py` |
| Foundation governance + upstream docs | `hb-platform`, `hb-bridge` | doc review |

## Verify commands

Run from `~/Desktop/hb-platform`:

```bash
make hb-verify-parallel
make hb-verify-workflow
make hb-verify-hbw
make hb-verify-registry
make hb-verify-format
make hb-verify-bridge
make hb-verify-gates
```

## Test counts (2026-06-06)

| Repo | Suite | Count |
|------|-------|-------|
| hnf | cargo test | 79 |
| hb-bridge | cargo + phase1 pytest | 48 + 11 |
| hbp-cloud | workflow engine | 23 |
| hbp-cloud | API + registry + marketplace + billing | 10 |
| hb | CLI pytest | 1+ |
| hbw | tsc + vite build | pass |

## Repos touched (Phase 1 waves)

| Repo | Branch | Key paths |
|------|--------|-----------|
| hb-platform | main | `docs/PHASE_1_EXIT.md`, `docs/ADR/0002-*`, `Makefile`, `docs/ci/` |
| hnf | main | `crates/hnf-core/src/domain/{bim,geospatial,structural,energy_building}.rs` |
| hb-bridge | main | `plugins/phase1/*`, `docs/upstream/*`, `test_phase1_plugins.py` |
| hbp-cloud | main | `packages/{registry,billing,workflow}`, `webhooks/`, API routers |
| hbw | main | `WorkflowComposerPage`, `MarketplacePage` |

## Next steps

1. Complete Phase 0.5 M4 evidence (soak JSON, status page, OSS tags).
2. Phase 2: HB Sim cloud per `ENGINEERING_PLAN_v8.md`.
3. Live Stripe + Tier B geometry roundtrip hardening.
