# Restore drill evidence (Phase 0.5 — local)

Fill this in after running a successful restore drill. Attach logs or link to CI artifact.

| Field | Value |
|-------|--------|
| **Executed (UTC)** | _YYYY-MM-DDTHH:MM:SSZ_ |
| **Operator** | _name / agent run id_ |
| **Mechanism** | _pick one:_ `infra/kind/restore-drill.sh` · `infra/kind/restore-drill-docker.sh` |
| **Source** | _kind namespace/pod or docker container name_ |
| **Backup size (bytes)** | _integer_ |
| **alembic_version rows** | _≥ 1 required for PASS_ |
| **RPO target** | ≤ 6 hours (Helm backup CronJob schedule) |
| **RTO target** | ≤ 30 minutes (scripted restore) |
| **Result** | _PASS / FAIL_ |

## Prerequisites (kind path)

1. Docker Desktop running
2. `./infra/kind/create-cluster.sh`
3. `./infra/kind/install-hbp.sh` (wait for Postgres Ready)
4. `./infra/kind/restore-drill.sh --dry-run` to print checklist without changes

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

_Failures, follow-ups, ticket links._
