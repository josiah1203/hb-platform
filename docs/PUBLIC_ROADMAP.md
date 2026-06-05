# HummingBird public roadmap (v8)

Last updated: 2026-06-05 (Phase 0 exit — 100%)

## Milestone status

| Milestone | Status | Notes |
|-----------|--------|-------|
| **M0 Format** | **100%** | All 7 domains, structural diff, `hb hnf inspect`; ADR-0001 + security signed |
| **M1 HOS + bridges** | **100%** | HOS graft + semantic merge; KiCad/FreeCAD in-progress with host roundtrip |
| **M2 Workflow + CLI + HBW** | **100%** | 10 built-ins, CLI workflow/config, HBW DAG + diff on main |
| **M3 Integration alpha** | **100%** | Workflow→HOS artifacts, HBW M3 surfaces, macOS Tauri CI, Week 20 demo |
| **M4 Phase 0.5 gates** | ~15% | Checklists + restore drill scripts; evidence templates added |
| **M5 Phase 1** | ~5% | JSON schema stubs + README placeholders |

## Phase 0 (complete — internal alpha)

Exit evidence: [`PHASE_0_EXIT.md`](PHASE_0_EXIT.md) · gate table: [`PHASE_0.md`](PHASE_0.md)

- [x] HNF spec v0.1 + all Phase 0 domain schemas + diff
- [x] Workflow engine v0.1 — 10 built-in checks, HOS artifact persistence
- [x] HBW Tauri alpha — Repos/History/Diff + M3 Automation/Review/Collab/Research
- [x] `hb` CLI — auth, validate, hnf inspect, workflow list/run, config
- [x] Semantic merge on main (`HOS_MERGE_ENGINE=semantic`)
- [x] HB Bridge — 13 tools harness-only+; KiCad/FreeCAD in-progress
- [x] CRDT collaboration service (Redis LWW per ADR-0001)
- [x] macOS Tauri CI artifact ([`hbw/docs/PACKAGING.md`](https://github.com/hummingbird-labs/hbw/blob/main/docs/PACKAGING.md))

## Phase 0.5 (beta-open gates — **next**)

See [`PHASE_0.5.md`](PHASE_0.5.md).

| Gate | Status |
|------|--------|
| 2-week stable alpha | Not started |
| Restore drill evidence | Script + [`docs/ops/restore_drill_local.md`](ops/restore_drill_local.md) template |
| 4h collab soak | Script exists; evidence JSON pending |
| Import &lt;5% loss | Corpus CI partial |
| Status page + IR | Not started |
| ToS / privacy / billing | Stubs in [`docs/legal/`](legal/) |
| Public OSS v0.1.0-alpha | Tags pending |
| Public roadmap | This document |
| Linux/Windows HBW packaging | Deferred from Phase 0 |

## Out of scope until post-0.5

HB Sim cloud, HB AI cloud, HB Fab/Ops/Twin, enterprise SSO, Phase 1 built-env disciplines.

## Out of scope permanently (v8)

In-browser CAD authoring; HCP-style fork IDE as primary seam.
