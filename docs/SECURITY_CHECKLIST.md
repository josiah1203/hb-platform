# Security checklist — Phase 0 Week 3

**Owner:** `security` agent (read-only review)  
**Gate:** M0 legal / GPL bridge boundary before public OSS publish  
**ADR:** [ADR-0001 — CRDT store](./ADR/0001-crdt-store.md) (Accepted 2026-06-05)

## GPL / LGPL bridge boundary

- [x] HB Bridge plugins are **in-process add-ons** to upstream tools (KiCad, FreeCAD, …), not forks — [hb-bridge/plugins/kicad/README.md](https://github.com/hummingbird-labs/hb-bridge/blob/main/plugins/kicad/README.md#v8-approach-not-a-fork), [freecad/README.md](https://github.com/hummingbird-labs/hb-bridge/blob/main/plugins/freecad/README.md#v8-approach-not-a-fork)
- [x] Apache 2.0 `hb-bridge` / `hnf` code does not statically link GPL libraries — [hb-bridge/README.md](https://github.com/hummingbird-labs/hb-bridge/blob/main/README.md) (Apache-2.0 workspace; Rust adapters + Python stubs only)
- [x] Roundtrip harness (`crates/protocol`, `crates/roundtrip-harness`) is headless CI only — not shipped to end users as a combined binary with GPL tools — [hb-bridge/plugins/README.md#m1m2-roundtrip](https://github.com/hummingbird-labs/hb-bridge/blob/main/plugins/README.md#m1m2-roundtrip), [corpora/README.md](https://github.com/hummingbird-labs/hb-bridge/blob/main/corpora/README.md)
- [x] Plugin README documents user-installed upstream tool + separate Bridge plugin install — [KiCad install paths](https://github.com/hummingbird-labs/hb-bridge/blob/main/plugins/kicad/README.md#install-path-kicad-8), [FreeCAD install](https://github.com/hummingbird-labs/hb-bridge/blob/main/plugins/freecad/README.md)
- [x] No GPL source in private `hbp-cloud` tree — `hbp-cloud` is Apache-2.0 API/services only; bridge GPL tools are external host installs (see bridge matrix above)

## CRDT / collaboration auth

- [x] Every CRDT op validated against JWT + project RBAC (`editor` minimum) — [`hbp-cloud/api/app/routers/collaboration.py`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/api/app/routers/collaboration.py) (`Depends(require_role("editor"))` on heartbeat, locks, CRDT ops); [`collaboration.py` service](https://github.com/hummingbird-labs/hbp-cloud/blob/main/api/app/services/collaboration.py) `_require_editor`
- [x] Ops scoped by `org_id` — no cross-tenant merge or replay — `CollaborationService._require_project(project_id, user.org_id)` and `CollaborationPresence.org_id == user.org_id` filters in [`collaboration.py`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/api/app/services/collaboration.py); CRDT keys namespaced by `project_id` in [`crdt_store.py`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/api/app/services/crdt_store.py)
- [x] Soft-lock TTL enforced server-side; orphaned lock audit in soak evidence — `LOCK_TTL_SECONDS` / `SOFT_LOCK_TTL_SECONDS` (300s) in [`crdt_store.py`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/api/app/services/crdt_store.py) and [`collaboration.py`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/api/app/services/collaboration.py); soak tracks `orphaned_lock_ids` in [`hbp-cloud/scripts/collaboration_soak.py`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/scripts/collaboration_soak.py) (runbook: [`docs/ops/collaboration_soak_local.json`](./ops/collaboration_soak_local.json))

## Plugin sandbox (Phase 0)

- [x] Bridge plugins run with upstream tool permissions only — no elevated cloud credentials in-plugin — [hb-bridge/README.md](https://github.com/hummingbird-labs/hb-bridge/blob/main/README.md) (in-tool plugins inside host CAD/E DA); [`plugin_stub.py`](https://github.com/hummingbird-labs/hb-bridge/blob/main/plugins/kicad/plugin_stub.py) has no API secrets; HOS/cloud access deferred to M2 panel via external `hb` CLI ([KiCad roadmap row 4](https://github.com/hummingbird-labs/hb-bridge/blob/main/plugins/kicad/README.md#upstream-pr-roadmap))
- [x] HOS tokens via `hb` CLI / OS-protected config — not embedded in plugin source — [`hb/hb/config.py`](https://github.com/hummingbird-labs/hb/blob/main/hb/config.py) (`~/.config/hb/config.json`, mode `0o600`, or `HBP_ACCESS_TOKEN`); [`hb/hb/main.py`](https://github.com/hummingbird-labs/hb/blob/main/hb/main.py) `hb auth login --save`

## Sign-off

| Reviewer | Date | Notes |
|----------|------|-------|
| coordinator / hcp-tech-lead (governance agent) | 2026-06-05 | M0 Week 3 gate: GPL boundary + CRDT auth + plugin sandbox evidenced; ADR-0001 Accepted |
