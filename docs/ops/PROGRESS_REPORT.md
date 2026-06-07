# HummingBird v8 — Program progress report

**Last updated:** 2026-06-07 · **Coordinator:** hb-platform

## Summary

| Phase | Milestone | Status | Verify |
|-------|-----------|--------|--------|
| **Phase 0** | M0–M3 internal alpha | **100%** | [`PHASE_0_EXIT.md`](PHASE_0_EXIT.md) |
| **Phase 0.5 local** | M4-local internal beta | **100%** | [`PHASE_0.5_LOCAL_EXIT.md`](../PHASE_0.5_LOCAL_EXIT.md) |
| **Phase 0.5 prod** | M4-prod external beta-open | **PENDING** | [`PHASE_0.5_PROD.md`](../PHASE_0.5_PROD.md) |
| **Phase 1** | M5 workflow cloud + built env | **100%** | [`PHASE_1_EXIT.md`](../PHASE_1_EXIT.md) |

## Phase 0.5 local (complete — 2026-06-07)

| Gate | Status | Evidence |
|------|--------|----------|
| Verify suite + strict gates | **PASS** | `make hb-verify-gates-local` |
| Local API harness | **PASS** | `hbp-cloud/scripts/dev-local.sh` |
| Collab soak (120 iter) | **PASS** | [`collaboration_soak_local.json`](collaboration_soak_local.json) |
| Restore drill (file) | **PASS** | [`restore_drill_local.md`](restore_drill_local.md) |
| Import &lt;5% loss | **PASS** | [`import_loss_local.md`](import_loss_local.md) — 0.00% |
| Status page (local) | **PASS** | [`docs/status/index.html`](../status/index.html) |
| Legal / billing stubs | **PASS** | `docs/legal/` |
| Release `v0.5-beta-local` | **PASS** | `release/v0.5-beta-local` + CHANGELOG |
| HBW live path | **PASS** | [`integration_smoke.md`](integration_smoke.md) |

ADR: [`ADR/0003-m4-local-vs-prod-gates.md`](../ADR/0003-m4-local-vs-prod-gates.md)

## Phase 0.5 prod (pending)

| Gate | Status | Notes |
|------|--------|-------|
| 2-week stable alpha | **PENDING** | `release/v0.5-beta` |
| Postgres restore drill | **PENDING** | kind/docker path |
| 4h collab soak | **PENDING** | 14400 iterations |
| External status URL | **PENDING** | Instatus / Better Uptime |
| Counsel legal | **PENDING** | Engineering stubs exist |
| Public OSS v0.5-beta | **PENDING** | Tags/releases |

## Phase 0 (complete)

- 7 HNF domains (Rust + JSON Schema + fixtures)
- 10 workflow built-in checks, HOS artifact persistence
- HBW Tauri alpha (Repos/History/Diff/Automation/Review/Collab/Research)
- `hb` CLI auth/validate/workflow
- HB Bridge Phase 0 plugins (KiCad, FreeCAD, …)
- ADR-0001 CRDT store decision

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
make hb-verify-gates-local
```

## Test counts (2026-06-07)

| Repo | Suite | Count |
|------|-------|-------|
| hnf | cargo test | 79 |
| hb-bridge | cargo + phase1 pytest | 48 + 11 |
| hbp-cloud | workflow engine | 23 |
| hbp-cloud | API + registry + marketplace + billing | 10 |
| hb | CLI pytest | 1+ |
| hbw | tsc + vite build | pass |

## Repos touched (Phase 0.5 local)

| Repo | Branch | Key paths |
|------|--------|-----------|
| hb-platform | main | `docs/ADR/0003-*`, `PHASE_0.5_*`, `scripts/phase05-gates.sh`, `docs/status/` |
| hbp-cloud | main | `scripts/dev-local.sh`, `local_restore_drill.sh`, `collaboration_soak.py` |
| hb-bridge | main | `scripts/import_loss_report.py` |
| hbw | main | `.env.local.example`, `integration_smoke.md` (hb-platform) |

**Final-verify (2026-06-07):** `run-phase05-local.sh` exit 0; all `hb-verify-*` targets exit 0; `PHASE_0.5_LOCAL_EXIT.md` 10/10 PASS.

## Next steps

1. M4-prod gates when Docker/kind + external hosting available.
2. Phase 2: HB Sim cloud per `ENGINEERING_PLAN_v8.md`.
3. Live Stripe + Tier B geometry roundtrip hardening.
