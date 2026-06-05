# Restore drill evidence (Phase 0.5 — local)

## Latest run

| Field | Value |
|-------|--------|
| **Executed (UTC)** | 2026-06-05T00:35:06Z |
| **Operator** | hcp-engineer-m4-gates |
| **Mechanism** | `hbp-cloud/infra/kind/restore-drill.sh` |
| **Mode** | `--dry-run` |
| **Docker** | **Unavailable** on gate host (`docker info` failed) |
| **Result** | **DRY-RUN PASS** — full drill **BLOCKED** |

## Dry-run output (2026-06-05T00:35:06Z)

```
Restore drill dry-run (20260605T003506Z)

Prerequisites:
  1. Docker Desktop running (ensure-tools.sh)
  2. kind cluster: ./infra/kind/create-cluster.sh
  3. Platform installed: ./infra/kind/install-hbp.sh
  4. Postgres Ready in namespace ${HBP_NAMESPACE:-hbp}

Command (no cluster changes):
  restore-drill.sh

Alternative without kind (docker-compose Postgres):
  ./infra/kind/restore-drill-docker.sh

Evidence template: hb-platform/docs/ops/restore_drill_local.md
```

## Full drill (not executed)

| Field | Value |
|-------|--------|
| **Source** | kind namespace `${HBP_NAMESPACE:-hbp}` / Postgres pod |
| **Backup size (bytes)** | _n/a_ |
| **alembic_version rows** | _n/a (≥ 1 required for PASS)_ |
| **RPO target** | ≤ 6 hours |
| **RTO target** | ≤ 30 minutes |
| **Result** | **BLOCKED** — start Docker, then kind path or `restore-drill-docker.sh` |

## Prerequisites (kind path)

1. Docker Desktop running
2. `./infra/kind/create-cluster.sh`
3. `./infra/kind/install-hbp.sh` (wait for Postgres Ready)
4. `./infra/kind/restore-drill.sh --dry-run`
5. `./infra/kind/restore-drill.sh` — update table with backup bytes + alembic row count

## Prerequisites (docker-compose path)

1. `docker compose up -d postgres` in `hbp-cloud`
2. Migrations applied (`alembic upgrade head` or API startup)
3. `./infra/kind/restore-drill-docker.sh`

## Optional API verify

```bash
kubectl -n hbp-restore port-forward pod/hbp-restore-pg 5433:5432
DATABASE_URL=postgresql+psycopg2://hcp:hcp@127.0.0.1:5433/hcp \
  cd ../hbp-cloud/api && PYTHONPATH=.. pytest tests/test_hos_version_control.py -q --maxfail=1
```

## Prior dry-run

2026-06-05T00:21:30Z — wave2-platform agent (same prerequisites; superseded by run above).
