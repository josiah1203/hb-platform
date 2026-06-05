# Status page — Phase 0.5 (M4)

**Gate status:** **BLOCKED** — external hosting not provisioned.

| Field | Value |
|-------|--------|
| **Public URL** | _pending_ (e.g. `status.hummingbirdlabs.io` or Better Stack / Instatus) |
| **Incident response** | Runbook TBD with platform + devrel |
| **Last updated (UTC)** | 2026-06-05T00:35:00Z |

## Planned components

- **Uptime** — HBP API, HOS object storage, collaboration WebSocket/presence
- **Maintenance** — scheduled windows for Postgres/Neo4j restore drills
- **Subscribe** — email/RSS webhook for beta customers

## Local substitute

Until a URL exists, gate evidence lives in [`M4_GATE_RUN.md`](M4_GATE_RUN.md) (Status page row: BLOCKED).

## User actions

1. Choose status vendor (Instatus, Better Uptime, etc.).
2. Point DNS + link from product footer and [`PHASE_0.5.md`](../PHASE_0.5.md).
3. Attach IR playbook (PagerDuty/Opsgenie) and mark gate **PASS** in `M4_GATE_RUN.md`.
