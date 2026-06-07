# Phase 0.5 production exit checklist (M4-prod)

**Status:** **PENDING** — deferred until Docker/kind infrastructure is available  
**ADR:** [`ADR/0003-m4-local-vs-prod-gates.md`](./ADR/0003-m4-local-vs-prod-gates.md)  
**Local exit (complete):** [`PHASE_0.5_LOCAL_EXIT.md`](./PHASE_0.5_LOCAL_EXIT.md)

M4-prod gates are required for **external beta-open**. They do not block M4-local 100% exit.

Binary rule: each row is **PASS** or **PENDING** until production evidence exists.

---

## Summary table

| # | Gate | Owner | Deliverable | Status | Evidence |
|---|------|-------|-------------|--------|----------|
| 1 | 2-week stable alpha | coordinator + all | Release branch `release/v0.5-beta` + public CHANGELOG | **PENDING** | — |
| 2 | Durability / restore (Postgres) | platform + hos | Full restore drill — `hbp-cloud/infra/kind/restore-drill.sh` or `restore-drill-docker.sh` | **PENDING** | [`restore_drill_local.md`](ops/restore_drill_local.md) has kind dry-run only |
| 3 | 4h collab soak | collab | 14400 iterations against compose/kind stack | **PENDING** | Local 120-iter PASS in [`collaboration_soak_local.json`](ops/collaboration_soak_local.json) (`tier: local`) |
| 4 | Import &lt;5% loss (live tools) | hos + bridge | CI corpus + optional host-tool roundtrip | **PENDING** | Headless 0% PASS local; live KiCad/FreeCAD host path optional |
| 5 | Status page + IR | platform + devrel | External URL (Instatus / Better Uptime / GitHub Pages) | **PENDING** | [`STATUS_PAGE.md`](ops/STATUS_PAGE.md) |
| 6 | ToS / privacy / billing | devrel + legal | Counsel-reviewed pages | **PENDING** | Engineering stubs in [`docs/legal/`](legal/) |
| 7 | Public OSS publish | format, bridge, hbw, cli | GitHub releases per public repo | **PENDING** | `v0.1.0-alpha` tags exist; `v0.5-beta` pending |
| 8 | Public roadmap | devrel | `docs/PUBLIC_ROADMAP.md` M4-prod = 100% | **PENDING** | Local tier marked 100% |

**Pass count:** 0 / 8

---

## Prerequisites

1. Docker Desktop running (`docker info` succeeds).
2. `docker compose up -d` in `hbp-cloud` **or** kind cluster via `infra/kind/create-cluster.sh`.
3. Migrations applied (`alembic upgrade head`).
4. External status vendor provisioned (DNS + subscribe webhook).
5. Legal counsel review of ToS, privacy, and billing pages.

---

## Verify commands (when infrastructure ready)

```bash
# Postgres restore drill (docker-compose path)
cd ~/Desktop/hbp-cloud
docker compose up -d postgres
./infra/kind/restore-drill-docker.sh

# 4h collaboration soak
export HBP_API_URL=http://localhost:8000
python3 scripts/collaboration_soak.py \
  --iterations 14400 --interval-s 1 \
  --tier prod --gate m4_prod_collab_soak \
  --log-file ../hb-platform/docs/ops/collaboration_soak_prod.json

# Prod gate verify (future)
cd ~/Desktop/hb-platform
PHASE05_TIER=prod make hb-verify-gates-prod
```

---

## Relationship to M4-local

| Concern | M4-local | M4-prod |
|---------|----------|---------|
| Database | SQLite file | Postgres |
| Storage | Local filesystem | Minio / S3 |
| CRDT | In-process | Redis |
| Soak duration | 120 iter (~2 min) | 14400 iter (4 h) |
| Restore | File copy drill | pg_dump / kind restore |
| Status | Static HTML | External URL |
| Legal | Engineering stubs | Counsel-approved |
