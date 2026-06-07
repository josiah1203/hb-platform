# Status page — Phase 0.5 (M4)

## M4-local (available now)

| Field | Value |
|-------|--------|
| **Tier** | local |
| **Static page** | [`docs/status/index.html`](../status/index.html) |
| **View locally** | `cd ~/Desktop/hb-platform/docs/status && python3 -m http.server 8765` → [http://localhost:8765/](http://localhost:8765/) |
| **File URL** | `file:///Users/josiah/Desktop/hb-platform/docs/status/index.html` |
| **API probe** | Fetches `http://localhost:8000/health/live` when `dev-local.sh` is running |
| **Gate status** | **PASS** — see [`PHASE_0.5_LOCAL_EXIT.md`](../PHASE_0.5_LOCAL_EXIT.md) row 6 |
| **Last updated (UTC)** | 2026-06-07 |

The local page shows M4-local gate PASS rows and live API health when the stack is up. It does not replace an external uptime monitor.

---

## M4-prod (deferred)

| Field | Value |
|-------|--------|
| **Public URL** | _pending_ (e.g. `status.hummingbirdlabs.io` or Better Stack / Instatus) |
| **Incident response** | Runbook TBD with platform + devrel |
| **Gate status** | **PENDING** — see [`PHASE_0.5_PROD.md`](../PHASE_0.5_PROD.md) |

### Planned components (prod)

- **Uptime** — HBP API, HOS object storage, collaboration WebSocket/presence
- **Maintenance** — scheduled windows for Postgres/Neo4j restore drills
- **Subscribe** — email/RSS webhook for beta customers

### User actions (prod)

1. Choose status vendor (Instatus, Better Uptime, etc.).
2. Point DNS + link from product footer and [`PHASE_0.5.md`](../PHASE_0.5.md).
3. Attach IR playbook (PagerDuty/Opsgenie) and mark gate **PASS** in `PHASE_0.5_PROD.md`.
