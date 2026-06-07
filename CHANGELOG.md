# Changelog — HummingBird Platform meta (hb-platform)

## [v0.5-beta-local] — 2026-06-07

Phase 0.5 **M4-local** exit — internal beta / dogfooding ready (no Docker required).

### M4-local gates (100%)

- **ADR-0003:** M4-local vs M4-prod tier split; honest scope boundary.
- **Local API harness:** `hbp-cloud/scripts/dev-local.sh` + `seed_dev.py` (SQLite + filesystem PAL).
- **Collab soak:** 120 iterations, `tier: local`, `passed: true` — [`collaboration_soak_local.json`](docs/ops/collaboration_soak_local.json).
- **Restore drill:** file-based sqlite+objects backup/restore — [`restore_drill_local.md`](docs/ops/restore_drill_local.md).
- **Import loss:** headless corpus 0.00% — [`import_loss_local.md`](docs/ops/import_loss_local.md).
- **Strict gates:** `make hb-verify-gates-local` validates evidence JSON/MD.
- **Status page:** [`docs/status/index.html`](docs/status/index.html) (local static + API health probe).
- **Orchestrator:** [`scripts/run-phase05-local.sh`](scripts/run-phase05-local.sh).

### Exit docs

- [`PHASE_0.5_LOCAL_EXIT.md`](docs/PHASE_0.5_LOCAL_EXIT.md) — all rows PASS.
- [`PHASE_0.5_PROD.md`](docs/PHASE_0.5_PROD.md) — prod gates PENDING (Docker/kind later).

### Deferred to M4-prod

- 4h collaboration soak, Postgres/kind restore drill, external status URL, counsel legal, public OSS v0.5-beta releases.

---

## [v0.1.0-alpha] — 2026-06-05

Phase 0.5 **M4 gate prep** and Phase 0 **M1–M3** deliverables across the v8 polyrepo.

### M0 — Format (hnf)

- HNF spec v0.1, JSON schemas, `hnf-core` schematic/BOM validate/parse/serialize (17 Rust tests).
- CRDT spike documented; Automerge-rs evaluation path for collab.

### M1 — HOS + bridges

- **hbp-cloud:** HOS version control API grafted from HCP `phase-0.5-beta-rc1`; semantic merge v0.1 on feature branches merged to main.
- **hb-bridge:** KiCad/FreeCAD headless roundtrip harness; corpus under `corpora/`; plugin status matrix in `plugins/README.md`.
- Phase 0 tool adapters (KLayout, ngspice, Yosys, Verilator, Magic, OpenROAD) — harness-only.

### M2 — Workflow, CLI, HBW

- **hbp-cloud:** Workflow engine v0.1 (trigger → condition → action; DRC/ERC/BOM builtins).
- **hb:** `hb auth`, `hb hnf validate`, `hb repo list` alpha.
- **hbw:** Tauri/React command-center shell (Repos, History, Diff routes).

### M3 — Integration alpha

- Offline smoke: `hb-platform/scripts/integration_smoke.sh` (HNF validate + headless roundtrip).
- KiCad → HOS path documented in `docs/ops/integration_smoke.md`.

### M4 — Phase 0.5 gates (this release)

- Verify Makefile targets + `phase05-gates.sh` with isolated `CARGO_TARGET_DIR`.
- Ops evidence: `docs/ops/M4_GATE_RUN.md`, collab soak JSON, restore drill log, status page stub.
- Public OSS tags/releases: `v0.1.0-alpha` on hnf, hb-bridge, hbw, hb.

### Known gaps (beta-open)

- 4h collaboration soak against production-like stack.
- Full Postgres restore drill (kind or docker-compose).
- External status page URL and counsel-reviewed legal/billing pages.
