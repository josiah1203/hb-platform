# ADR-0001 — CRDT store for Phase 0 collaboration

**Status:** Accepted  
**Date:** 2026-06-05  
**Owners:** `collab` + `coordinator` (tech-lead sign-off)

## Context

M0 Week 4 requires a recorded decision on collaboration storage before M3 wires HBW `/collab` to live APIs. A spike compared [Automerge-rs](https://github.com/automerge/automerge) (MIT) and [Diamond Types](https://github.com/josephg/diamond-types) (Apache-2.0/MIT) for structured HNF object graphs, wire size, and Rust/Python integration (see closed spikes in `hnf/docs/CRDT_SPIKE.md` and `hbp-cloud/docs/CRDT_SPIKE.md`).

Phase 0 must ship **JWT + RBAC–scoped** presence, advisory soft locks, and a document op log without blocking on a full CRDT library integration.

## Decision

**Phase 0 (now):** Use the implemented **Redis LWW op log + Postgres durable rows** pattern in `hbp-cloud/api/app/services/crdt_store.py`, orchestrated by `CollaborationService` (`api/app/services/collaboration.py`):

| Layer | Backend | Role |
|-------|---------|------|
| Durable presence / soft locks | Postgres (`collaboration_presence`, `collaboration_soft_locks`) | Source of truth for API responses and audit |
| Op log + fast presence/lock mirror | Redis (`REDIS_URL`) when reachable | Idempotent op merge, cross-pod reads |
| Local dev / pytest | In-memory fallback in `CrdtStore` | CI without Redis |

Merge semantics for document ops: **last-writer-wins path merge** (`op_type` set/delete on `payload.path`) until a structured CRDT payload replaces it.

**Phase 0.5 (next):** Evaluate **Automerge** as the primary structured-document CRDT (object-graph fit, mature bindings). Keep **Diamond Types** as a fallback for text-heavy paths if Automerge wire size fails soak p95. Wire chosen payloads into `envelope.crdt_payload` on `/v1/collaboration/crdt/operations`; retain Postgres durability and Redis fan-out.

## Consequences

- **Positive:** Matches production code today; M0/M3 gates unblocked; idempotent ops and server-side lock TTL (300s) already enforced in `crdt_store.py`.
- **Positive:** Security checklist can cite concrete auth boundaries (`require_role("editor")`, `org_id` project scoping) before library swap.
- **Negative:** LWW path merge is not a true multi-user CRDT for concurrent edits on the same path — acceptable for Phase 0 advisory collab; must not be marketed as OT/CRDT-complete until 0.5.
- **Follow-up:** ADR amendment required if Phase 0.5 selects Diamond over Automerge; re-run `scripts/collaboration_soak.py` (4h gate) after `crdt_payload` integration.

## References

- Implementation: `hbp-cloud/api/app/services/crdt_store.py`, `hbp-cloud/api/app/routers/collaboration.py`
- Security: [`SECURITY_CHECKLIST.md`](../SECURITY_CHECKLIST.md)
- Spikes (closed): `hnf/docs/CRDT_SPIKE.md`, `hbp-cloud/docs/CRDT_SPIKE.md`
