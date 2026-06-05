# Status page — Phase 0.5 gate (stub)

**Gate status:** **BLOCKED** — pending external hosting  
**Last updated (UTC):** 2026-06-05T00:29:53Z

## Planned URL

`https://status.hummingbird.dev` (placeholder — not provisioned)

## What will be published at beta-open

- API availability (HBP `/v1/health`)
- Object store ingest latency (p50/p99)
- Collaboration service heartbeat success rate
- Scheduled maintenance windows

## Incident response (IR)

- **Owner:** platform + devrel (per [`PHASE_0.5.md`](../PHASE_0.5.md))
- **Runbook:** not hosted yet — draft in private `hbp-cloud` ops docs when cluster is live
- **Escalation:** contact-sales / on-call TBD before public beta

## Local substitute (development only)

```bash
curl -s "${HBP_API_URL:-http://localhost:8000}/health"
```

Do not treat localhost health as satisfying the M4 status-page gate.

## Next steps

1. Choose provider (Statuspage.io, Instatus, or static + synthetic checks).
2. Wire checks to staging/production `HBP_API_URL`.
3. Link from HBW shell and `docs/PUBLIC_ROADMAP.md`.
