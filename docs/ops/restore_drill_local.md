# Restore drill evidence (Phase 0.5 — local)

Dry-run captured **2026-06-05T00:21:30Z** from `hbp-cloud/infra/kind/restore-drill.sh --dry-run`.

| Field | Value |
|-------|--------|
| **Executed (UTC)** | 2026-06-05T00:21:30Z |
| **Operator** | wave2-platform agent (dry-run only) |
| **Mechanism** | `infra/kind/restore-drill.sh` |
| **Source** | kind namespace `${HBP_NAMESPACE:-hbp}` / Postgres pod |
| **Backup size (bytes)** | _n/a — dry-run_ |
| **alembic_version rows** | _n/a — dry-run (≥ 1 required for PASS)_ |
| **RPO target** | ≤ 6 hours (Helm backup CronJob schedule) |
| **RTO target** | ≤ 30 minutes (scripted restore) |
| **Result** | **DRY-RUN** (prerequisites documented; full drill pending kind cluster) |

## Dry-run output

```
Restore drill dry-run (20260605T002130Z)

Prerequisites:
  1. Docker Desktop running (ensure-tools.sh)
  2. kind cluster: ./infra/kind/create-cluster.sh
  3. Platform installed: ./infra/kind/install-hbp.sh
  4. Postgres Ready in namespace ${HBP_NAMESPACE:-hbp}

Command (no cluster changes):
  ./infra/kind/restore-drill.sh

Alternative without kind (docker-compose Postgres):
  ./infra/kind/restore-drill-docker.sh

Evidence template: hb-platform/docs/ops/restore_drill_local.md
```

## Prerequisites (kind path)

1. Docker Desktop running
2. `./infra/kind/create-cluster.sh`
3. `./infra/kind/install-hbp.sh` (wait for Postgres Ready)
4. `./infra/kind/restore-drill.sh --dry-run` to print checklist without changes
5. `./infra/kind/restore-drill.sh` for full PASS evidence (update table above)

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

## Notes

Full restore drill requires a running kind cluster or docker-compose Postgres. This evidence stub satisfies Phase 0.5 documentation until a live drill is executed.
