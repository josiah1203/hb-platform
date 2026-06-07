# Phase 0.5 local exit checklist (M4-local)

**Coordinator sign-off:** 2026-06-07  
**Verdict:** Phase 0.5 local = **100%** (internal beta / dogfooding ready)  
**ADR:** [`ADR/0003-m4-local-vs-prod-gates.md`](./ADR/0003-m4-local-vs-prod-gates.md)  
**Prod gates:** deferred — see [`PHASE_0.5_PROD.md`](./PHASE_0.5_PROD.md)

Binary rule: each row is **PASS** or **BLOCKED** with evidence. No partial credit.

---

## Summary table

| # | Gate | Status | Evidence |
|---|------|--------|----------|
| 1 | Verify suite | **PASS** | `make hb-verify-parallel hb-verify-collab hb-verify-workflow hb-verify-gates-local` exit 0 |
| 2 | Local API harness | **PASS** | [`hbp-cloud/scripts/dev-local.sh`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/scripts/dev-local.sh) + [`seed_dev.py`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/scripts/seed_dev.py); `/health/live` ok |
| 3 | Collab soak (120 iter) | **PASS** | [`docs/ops/collaboration_soak_local.json`](ops/collaboration_soak_local.json) — `tier: local`, `passed: true` |
| 4 | Restore drill (sqlite+objects) | **PASS** | [`docs/ops/restore_drill_local.md`](ops/restore_drill_local.md) — local tier **PASS** (2026-06-07T04:02:30Z) |
| 5 | Import &lt;5% loss (headless) | **PASS** | [`docs/ops/import_loss_local.md`](ops/import_loss_local.md) + [`import_loss_local.json`](ops/import_loss_local.json) — 0.00% loss |
| 6 | Status page (local static) | **PASS** | [`docs/status/index.html`](status/index.html) |
| 7 | Legal / billing stubs | **PASS** | [`docs/legal/TOS.md`](legal/TOS.md), [`PRIVACY.md`](legal/PRIVACY.md), [`BILLING.md`](legal/BILLING.md) — engineering beta-ready |
| 8 | Public roadmap updated | **PASS** | [`PUBLIC_ROADMAP.md`](./PUBLIC_ROADMAP.md) — M4-local 100% |
| 9 | Release branch | **PASS** | `release/v0.5-beta-local` + [`CHANGELOG.md`](../CHANGELOG.md) v0.5-beta-local entry |
| 10 | HBW live path documented | **PASS** | [`docs/ops/integration_smoke.md`](ops/integration_smoke.md) — local quickstart |

**Blocked count:** 0

---

## Exit criteria

| # | Requirement | Status |
|---|-------------|--------|
| 1 | [`PHASE_0.5.md`](./PHASE_0.5.md) M4-local table — all rows green | **PASS** |
| 2 | `make hb-verify-gates-local` | **PASS** |
| 3 | `./scripts/run-phase05-local.sh` (optional full orchestrator) | **PASS** |
| 4 | ADR-0003 accepted | **PASS** |
| 5 | M4-prod gates documented separately (not blocking) | **PASS** |

---

## Verify commands

```bash
cd ~/Desktop/hb-platform
make hb-verify-gates-local

# Full local orchestrator (regenerates evidence):
./scripts/run-phase05-local.sh
```

---

## Branch merge record (feat/hb-v8-phase05-* → main)

| Repo | Branch | Merged to main |
|------|--------|----------------|
| hbp-cloud | `feat/hb-v8-phase05-local-harness` | ✅ (local-dev PAL) |
| hbp-cloud | `feat/hb-v8-phase05-local-evidence` | ✅ (soak tier + restore drill) |
| hb-bridge | `feat/hb-v8-phase05-local-evidence` | ✅ (`import_loss_report.py`) |
| hb-platform | `feat/hb-v8-phase05-local-evidence` | ✅ (evidence JSON/MD + orchestrator) |
| hb-platform | `feat/hb-v8-phase05-local-docs` | ✅ (ADR-0003, exit docs, strict gates) |
| hbw | `feat/hb-v8-phase05-local-hbw` | ✅ (`.env.local.example`, integration docs) |
