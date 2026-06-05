# Changelog — HummingBird Platform meta (hb-platform)

## [v0.1.0-alpha] — 2026-06-05

Public alpha slice across the v8 polyrepo program (Phase 0 M1–M3 + Phase 0.5 M4 evidence pass).

### M0 — Format

- HNF spec v0.1 and domain schemas in `hnf`
- Schematic + BOM validate/parse/serialize (`hnf-core`, 17 Rust tests)
- CRDT spike documentation (Automerge-rs vs Diamond Types)

### M1 — HOS + bridges

- HOS API grafted into `hbp-cloud` (version control, import pipeline)
- KiCad + FreeCAD headless roundtrip harness (`hb-bridge`)
- Collaboration API surface (presence, soft-lock) with pytest coverage

### M2 — Workflow, CLI, HBW

- Workflow engine v0.1 (trigger → condition → action, DRC/ERC/BOM builtins)
- `hb` CLI: `auth`, `hnf validate`, `repo list`
- HBW Tauri/React command-center shell (Repos, History, Diff routes)

### M3 — Integration alpha

- Offline integration smoke: `hb hnf validate` → headless bridge roundtrip
- Semantic merge v0.1 tests on `hbp-cloud`
- Helm chart validation (`hbp-platform`) and restore-drill scripts

### M4 — Phase 0.5 gates (this release)

- Verify Makefile targets + `phase05-gates.sh` (isolated `CARGO_TARGET_DIR`)
- Ops evidence: `docs/ops/M4_GATE_RUN.md`, restore drill dry-run, collab soak blocker doc
- Public OSS GitHub releases: `hnf`, `hb-bridge`, `hbw`, `hb` @ `v0.1.0-alpha`
- Legal stubs: ToS, Privacy, Billing (counsel review pending)

### Known limitations

- 4h collab soak and full restore drill require Docker/kind (blocked on local gate host)
- Status page and legal docs are stubs until external hosting and sign-off
- HB Sim cloud, HB AI cloud, enterprise SSO — out of Phase 0.5 scope

### Repositories

| Repo | Visibility | Tag |
|------|------------|-----|
| hnf | public | v0.1.0-alpha |
| hb-bridge | public | v0.1.0-alpha |
| hbw | public | v0.1.0-alpha |
| hb | public | v0.1.0-alpha |
| hbp-cloud | private | — |
| hb-platform | meta | release/v0.1.0-alpha |
