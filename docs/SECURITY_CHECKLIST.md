# Security checklist — Phase 0 Week 3

**Owner:** `security` agent (read-only review)  
**Gate:** M0 legal / GPL bridge boundary before public OSS publish

## GPL / LGPL bridge boundary

- [ ] HB Bridge plugins are **in-process add-ons** to upstream tools (KiCad, FreeCAD, …), not forks
- [ ] Apache 2.0 `hb-bridge` / `hnf` code does not statically link GPL libraries
- [ ] Roundtrip harness (`crates/protocol`) is headless CI only — not shipped to end users as a combined binary with GPL tools
- [ ] Plugin README documents user-installed upstream tool + separate Bridge plugin install
- [ ] No GPL source in private `hbp-cloud` tree

## CRDT / collaboration auth

- [ ] Every CRDT op validated against JWT + project RBAC (`editor` minimum)
- [ ] Ops scoped by `org_id` — no cross-tenant merge or replay
- [ ] Soft-lock TTL enforced server-side; orphaned lock audit in soak evidence

## Plugin sandbox (Phase 0)

- [ ] Bridge plugins run with upstream tool permissions only — no elevated cloud credentials in-plugin
- [ ] HOS tokens via `hb` CLI / OS keychain — not embedded in plugin source

## Sign-off

| Reviewer | Date | Notes |
|----------|------|-------|
| _pending_ | | Week 3 M0 gate |
