# HummingBird public roadmap (v8)

Last updated: 2026-06-07 (Phase 0.5 local exit — 100%)

## Milestone status

| Milestone | Status | Notes |
|-----------|--------|-------|
| **M0 Format** | **100%** | All 7 Phase 0 domains + 4 Phase 1 domains; ADR-0001/0002 |
| **M1 HOS + bridges** | **100%** | HOS graft + semantic merge; Phase 1 bridge harness (10 tools) |
| **M2 Workflow + CLI + HBW** | **100%** | 13 built-ins, composer UI, marketplace |
| **M3 Integration alpha** | **100%** | Workflow→HOS artifacts, HBW M3 surfaces |
| **M4 Phase 0.5 local** | **100%** | M4-local gates — [`PHASE_0.5_LOCAL_EXIT.md`](PHASE_0.5_LOCAL_EXIT.md) |
| **M4 Phase 0.5 prod** | **PENDING** | External beta-open — [`PHASE_0.5_PROD.md`](PHASE_0.5_PROD.md) |
| **M5 Phase 1** | **100%** | Workflow cloud + built-environment disciplines |

## Phase 0 (complete — internal alpha)

Exit evidence: [`PHASE_0_EXIT.md`](PHASE_0_EXIT.md)

## Phase 0.5 — M4-local (complete — internal beta)

Exit evidence: [`PHASE_0.5_LOCAL_EXIT.md`](PHASE_0.5_LOCAL_EXIT.md) · ADR: [`ADR/0003`](ADR/0003-m4-local-vs-prod-gates.md)

| Gate | Status |
|------|--------|
| Verify suite + strict gates | **PASS** |
| Local API harness | **PASS** |
| Collab soak (120 iter) | **PASS** |
| Restore drill (file) | **PASS** |
| Import &lt;5% loss (headless) | **PASS** — 0.00% |
| Status page (local) | **PASS** |
| ToS / privacy / billing stubs | **PASS** |
| Release `v0.5-beta-local` | **PASS** |
| HBW live path documented | **PASS** |

Verify: `make hb-verify-gates-local`

## Phase 0.5 — M4-prod (pending — external beta-open)

See [`PHASE_0.5_PROD.md`](PHASE_0.5_PROD.md). Does not block Phase 1 or M4-local exit.

| Gate | Status |
|------|--------|
| 2-week stable alpha (`release/v0.5-beta`) | **PENDING** |
| Postgres restore drill | **PENDING** |
| 4h collab soak | **PENDING** |
| Import &lt;5% loss (live tools) | **PENDING** |
| External status page + IR | **PENDING** |
| Counsel-reviewed legal/billing | **PENDING** |
| Public OSS v0.5-beta releases | **PENDING** |

## Phase 1 (complete — workflow cloud + built env)

Exit evidence: [`PHASE_1_EXIT.md`](PHASE_1_EXIT.md)

- [x] Visual workflow composer + marketplace UI (HBW)
- [x] Marketplace API + webhooks + workflow-minute billing stub
- [x] Branch protection + sim/AI gate hooks
- [x] HNF domains: bim, geospatial, structural, energy_building
- [x] 10 Phase 1 bridge plugins (harness roundtrip)
- [x] Built-in checks: IFC, structural, energy model
- [x] Private component registry (paid-org gated)
- [x] Foundation governance + upstream PR docs
- [x] CI/CD GitHub Actions template

## Out of scope until Phase 2+

HB Sim cloud, HB AI cloud, HB Fab/Ops/Twin, enterprise SSO, Tier C native parametric interchange.

## Out of scope permanently (v8)

In-browser CAD authoring; HCP-style fork IDE as primary seam.
