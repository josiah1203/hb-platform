# Phase 1 exit checklist (M5, Week 28–44)

**Exit date:** 2026-06-06 · **Status:** PASS (100%)

## Workstream A — Workflow cloud

| Gate | Deliverable | Verify | Status |
|------|-------------|--------|--------|
| A1 | Visual workflow composer (HBW Automation Studio) | `make hb-verify-hbw` | **PASS** — `hbw/src/pages/WorkflowComposerPage.tsx` |
| A2 | Marketplace API | `hbp-cloud/packages/workflow/marketplace/` | **PASS** — list/publish/install API + tests |
| A3 | Marketplace listing UI | HBW `/automation/marketplace` | **PASS** — `MarketplacePage.tsx` |
| A4 | Webhooks (Slack, email, JIRA, Linear, HTTP) | `hbp-cloud/webhooks/` | **PASS** — router + handlers wired in engine |
| A5 | Branch protection + sim/AI gate hooks | workflow engine | **PASS** — `engine/gates.py` + `ActionKind.GATE` |
| A6 | Workflow-minute billing (Stripe stub) | `hbp-cloud/packages/billing/` | **PASS** — `WorkflowMetering` + Stripe event stub |
| A7 | CI/CD templates | `hb-platform/docs/ci/` | **PASS** — GitHub Actions template |

## Workstream B — Built environment

| Gate | Deliverable | Verify | Status |
|------|-------------|--------|--------|
| B1 | HNF domain: `bim` | `hnf/schemas/domains/bim.json` + Rust | **PASS** |
| B2 | HNF domain: `geospatial` | schema + Rust + fixtures | **PASS** |
| B3 | HNF domain: `structural` | schema + Rust + fixtures | **PASS** |
| B4 | HNF domain: `energy_building` | schema + Rust + fixtures | **PASS** |
| B5 | ADR-0002 interchange tiers | `docs/ADR/0002-interchange-tiers.md` | **PASS** |
| B6 | Mechanical semantic superset + STEP blobs | `mechanical.json` + FreeCAD adapter | **PASS** |
| B7 | 10 Phase 1 bridge plugins | `hb-bridge/plugins/phase1/` | **PASS** — harness roundtrip each |
| B8 | Built-in workflow checks (IFC, structural, energy) | `workflow/checks/` | **PASS** — 3 new checks (13 total) |
| B9 | Private component registry | `hbp-cloud/packages/registry/` | **PASS** — paid-org gated API |
| B10 | Upstream PR docs | `hb-bridge/docs/upstream/` | **PASS** — 10 tool docs |
| B11 | Foundation governance | `docs/FOUNDATION_GOVERNANCE.md` | **PASS** |

## Verify commands (all PASS)

```bash
cd ~/Desktop/hb-platform
make hb-verify-parallel    # PASS
make hb-verify-workflow    # PASS (23 engine + 10 API/marketplace)
make hb-verify-hbw         # PASS (tsc + vite build)
make hb-verify-registry    # PASS (registry + webhooks + billing)
make hb-verify-format      # PASS (hnf cargo test — 79 tests)
make hb-verify-bridge      # PASS (cargo + 11 phase1 pytest)
make hb-verify-gates       # PASS
```

## Known deferrals (honest BLOCKED)

| Item | Status | Owner | Notes |
|------|--------|-------|-------|
| Phase 0.5 M4 evidence (4h soak JSON, status page URL) | **BLOCKED** | platform + devrel | Scripts exist; production evidence pending |
| Tier B geometry roundtrip (IFC/STEP live blobs) | **DEFERRED** | bridge | Harness-only; ADR-0002 documents matrix |
| Stripe live webhook endpoints | **DEFERRED** | platform | Metering stub records events |
| Upstream PRs merged to host OSS | **DEFERRED** | bridge + devrel | PR docs filed; merge pending host review |

## Sign-off

Phase 1 M5 implementation complete. Proceed to Phase 2 planning per `ENGINEERING_PLAN_v8.md`.
