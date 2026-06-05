# HummingBird public roadmap (v8)

Last updated: 2026-06-04 (Phase 2c platform infra pass)

## Milestone status

| Milestone | Status | Notes |
|-----------|--------|-------|
| **M0 Format** | ~60% | HNF spec v0.1, schematic/BOM in `hnf`; CRDT spike doc only |
| **M1 HOS + bridges** | ~50% | HOS grafted + tests green; KiCad/FreeCAD harness; semantic merge on feature branch |
| **M2 Workflow + CLI + HBW** | ~40% | Engine v0.1, CLI alpha, HBW Tauri shell — feature branches |
| **M3 Integration alpha** | ~10% | End-to-end HB → HOS → HBW smoke not wired |
| **M4 Phase 0.5 gates** | ~15% | Checklists + restore drill scripts; evidence templates added |
| **M5 Phase 1** | ~5% | JSON schema stubs + README placeholders |

## Shipped via graft (HCP phase-0.5-beta-rc1 baseline)

HOS/VC, HNF validation, collaboration polling stub, events, import pipeline, `hb` CLI (from `hw`), KiCad/FreeCAD Rust mappings, kind/Helm data plane scripts.

## Phase 0 (in progress in polyrepo)

- [x] HNF spec v0.1 + domain schemas (M0 partial)
- [x] Workflow engine v0.1 (branch)
- [x] HBW Tauri alpha shell (branch)
- [x] `hb` CLI auth / validate / repo list (branch)
- [ ] Semantic merge behind `HOS_MERGE_ENGINE=semantic` (branch, not merged)
- [ ] HB Bridge plugins beyond KiCad/FreeCAD stubs
- [ ] CRDT collaboration service (replaces polling stub)

## Phase 0.5 (beta-open gates — next)

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

## Out of scope until post-0.5

HB Sim cloud, HB AI cloud, HB Fab/Ops/Twin, enterprise SSO, Phase 1 built-env disciplines.

## Out of scope permanently (v8)

In-browser CAD authoring; HCP-style fork IDE as primary seam.
