# ADR-0003 — M4-local vs M4-prod gate tiers

**Status:** Accepted  
**Date:** 2026-06-07  
**Owners:** platform + tech-lead (Phase 0.5 sign-off)

## Context

Phase 0.5 (M4) originally described a single checklist aimed at **external beta-open**: 4-hour collaboration soak, kind/Docker restore drill, external status URL, counsel-reviewed legal, and public OSS releases. Running those gates requires Docker Desktop, a kind cluster or compose Postgres, and hosted infrastructure — blocking fast iteration on M4 Macs used for internal dogfooding.

Engineering plan v8 already separates **internal alpha** (Phase 0) from **beta-open** (Phase 0.5). This ADR splits Phase 0.5 into two explicit tiers so local development can reach **100% exit** without pretending production evidence exists.

## Decision

Adopt two gate tiers for Phase 0.5:

| Tier | Audience | Stack | Exit doc |
|------|----------|-------|----------|
| **M4-local** | Internal beta / dogfooding | `HCP_PROVIDER=local-dev` — SQLite, filesystem objects, in-process CRDT, uvicorn on `:8000` | [`PHASE_0.5_LOCAL_EXIT.md`](../PHASE_0.5_LOCAL_EXIT.md) |
| **M4-prod** | External beta-open | Docker compose or kind, Postgres, Minio, Redis, Neo4j, external status URL | [`PHASE_0.5_PROD.md`](../PHASE_0.5_PROD.md) |

### What M4-local proves

- Local API harness (`dev-local.sh`, `seed_dev.py`) serves `/health/live` with PAL local providers.
- Collaboration soak **120 iterations** (~2 min) against live API with `tier: local`, `passed: true`.
- File-based restore drill: SQLite DB + object dir backup/restore with row-count verification.
- Headless import-loss corpus **&lt;5%** aggregate loss (`import_loss_report.py`).
- Static local status page (`docs/status/index.html`).
- Beta-ready legal/billing **stubs** (engineering sign-off; not counsel-approved).
- Release branch `release/v0.5-beta-local` + CHANGELOG (no Docker required).
- HBW live path documented in `integration_smoke.md`.

### What M4-local does **not** prove

- 4-hour (14400-iteration) production collaboration soak.
- Postgres/kind restore drill with alembic_version verification.
- Minio object-store semantics under load.
- External uptime status URL or incident-response playbook.
- Counsel-reviewed ToS/privacy/billing pages.
- Live Stripe billing.
- Public OSS GitHub releases for all repos.

Those remain **M4-prod** gates in [`PHASE_0.5_PROD.md`](../PHASE_0.5_PROD.md) and do not block M4-local exit.

### Evidence contract

All local evidence artifacts carry explicit tier metadata:

| Artifact | Required fields |
|----------|-----------------|
| `collaboration_soak_local.json` | `tier: "local"`, `gate: "m4_local_collab_soak"`, `passed: true` |
| `restore_drill_local.md` | Section `Local tier run` with `**Result** \| **PASS** \|` |
| `import_loss_local.json` | `tier: "local"`, `passed: true`, `aggregate_loss_ratio < 0.05` |

Gate script `scripts/phase05-gates.sh` validates these when `PHASE05_TIER=local` (default).

## Consequences

- **Positive:** M4 Mac developers can run `./scripts/run-phase05-local.sh` and `make hb-verify-gates-local` without Docker.
- **Positive:** Honest roadmap: Phase 0.5 local = 100%, prod = pending.
- **Positive:** Prod gates unchanged — existing kind/docker scripts apply when infrastructure is available.
- **Negative:** SQLite schema drift vs Postgres must be documented; prod tier is authoritative for external beta.
- **Negative:** 120-iter soak ≠ 4h soak; ADR + JSON `tier` field prevent false equivalence.

## References

- [`PHASE_0.5.md`](../PHASE_0.5.md) — split M4-local / M4-prod tables
- [`PHASE_0.5_LOCAL_EXIT.md`](../PHASE_0.5_LOCAL_EXIT.md)
- [`PHASE_0.5_PROD.md`](../PHASE_0.5_PROD.md)
- `hbp-cloud/scripts/dev-local.sh`, `local_restore_drill.sh`
- `hb-bridge/scripts/import_loss_report.py`
- Plan: `phase_0.5_local_finish` (WS-C)
