# HummingBird public roadmap (v8)

Last updated: 2026-06-06 (Phase 1 exit — 100%)

## Milestone status

| Milestone | Status | Notes |
|-----------|--------|-------|
| **M0 Format** | **100%** | All 7 Phase 0 domains + 4 Phase 1 domains; ADR-0001/0002 |
| **M1 HOS + bridges** | **100%** | HOS graft + semantic merge; Phase 1 bridge harness (10 tools) |
| **M2 Workflow + CLI + HBW** | **100%** | 13 built-ins, composer UI, marketplace |
| **M3 Integration alpha** | **100%** | Workflow→HOS artifacts, HBW M3 surfaces |
| **M4 Phase 0.5 gates** | ~55% | Checklists + scripts; evidence templates — some BLOCKED |
| **M5 Phase 1** | **100%** | Workflow cloud + built-environment disciplines |

## Phase 0 (complete — internal alpha)

Exit evidence: [`PHASE_0_EXIT.md`](PHASE_0_EXIT.md)

## Phase 0.5 (beta-open gates — in progress)

See [`PHASE_0.5.md`](PHASE_0.5.md). Does not block Phase 1 implementation.

| Gate | Status |
|------|--------|
| 2-week stable alpha | Not started |
| Restore drill evidence | Script + template PASS |
| 4h collab soak | Script exists; evidence JSON pending |
| Import &lt;5% loss | Corpus CI partial |
| Status page + IR | Not started |
| ToS / privacy / billing | Stubs in [`docs/legal/`](legal/) |
| Public OSS v0.1.0-alpha | Tags pending |
| Public roadmap | This document |

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
