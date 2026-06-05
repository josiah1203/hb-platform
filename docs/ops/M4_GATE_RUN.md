# Phase 0.5 M4 gate run — HummingBird Labs v8

**Executed (UTC):** 2026-06-05T00:35:00Z  
**Branch:** `feat/hb-v8-m4-gates`  
**Operator:** hcp-engineer (local gate executor)  
**Host:** macOS darwin 24.4.0 — Docker daemon **not running**

## Gate summary

| Gate | Status | Evidence |
|------|--------|----------|
| Verify suite (`hb-verify-*`, integration smoke) | **PASS** | This doc §Verify suite |
| 4h collab soak | **BLOCKED** | [`collaboration_soak_local.json`](collaboration_soak_local.json) |
| Durability / restore (full drill) | **BLOCKED** | [`restore_drill_local.md`](restore_drill_local.md) (dry-run **PASS**) |
| Import &lt;5% loss (headless corpus) | **PASS** | §Import loss |
| Public OSS v0.1.0-alpha releases | **PASS** | §OSS releases (pre-existing on GitHub) |
| 2-week stable alpha / release branch | **PASS** | `release/v0.1.0-alpha` + [`CHANGELOG.md`](../../CHANGELOG.md) |
| ToS / privacy / billing | **PASS** (stub) | [`docs/legal/`](../legal/) — counsel sign-off **pending** |
| Status page + IR | **BLOCKED** | [`STATUS_PAGE.md`](STATUS_PAGE.md) — external hosting pending |
| Public roadmap | **PASS** | [`docs/PUBLIC_ROADMAP.md`](../PUBLIC_ROADMAP.md) |

## Verify suite

All runnable targets from `hb-platform` root (`/Users/josiah/Desktop/hb-platform`):

| Target | Exit | Summary |
|--------|------|---------|
| `make hb-verify-gates` | 0 | Docs OK; hnf 17 tests; hb-bridge cargo; hbp-cloud 18 pytest |
| `make hb-verify-parallel` | 0 | format + bridge + hos (27 pytest) + cli 1 test |
| `make hb-verify-collab` | 0 | 9 passed (`test_collaboration.py`) |
| `make hb-verify-platform` | 0 | helm lint/template OK; restore-drill dry-run prerequisites |
| `make hb-verify-workflow` | 0 | 5 passed (`test_workflow_engine.py`) |
| `./scripts/integration_smoke.sh` | 0 | HNF validate valid; headless roundtrip OK |

### hb-verify-gates excerpt

```
hb/gates: stub passed (docs + unit tests; full gates require M4 evidence)
hnf: 17 passed
hb-bridge: cargo test OK
hbp-cloud pytest subset: 18 passed
```

## Collab soak

**Status: BLOCKED** — `http://localhost:8000` connection refused; Docker unavailable.

Attempted smoke: `collaboration_soak.py --iterations 3` → login failed (connection refused). Evidence JSON updated with blocker metadata.

**User action to PASS:**

1. Start Docker Desktop.
2. `cd ../hbp-cloud && docker compose up -d` (wait for API healthy).
3. Create or use a project UUID with editor role.
4. Smoke: `--iterations 60 --interval-s 1` (~1 min).
5. Production gate: `--iterations 14400 --interval-s 1` (~4 h) → update JSON `status` to `PASS`.

## Restore drill

| Step | Status |
|------|--------|
| `restore-drill.sh --dry-run` | **PASS** (2026-06-05T00:35:06Z) |
| Full drill (kind or docker-compose) | **BLOCKED** — Docker daemon down |

See [`restore_drill_local.md`](restore_drill_local.md).

## Import &lt;5% loss

Headless roundtrip gate (no host KiCad/FreeCAD):

```bash
cd ../hb-bridge
cargo test -p roundtrip-harness -q   # 10 passed, 6 ignored (host-only)
python3 scripts/regression/run_suite.py roundtrip --corpus corpora/roundtrip/manifest.json  # exit 0
```

**Result:** **PASS** for CI harness / stub bindings. Host-OSS roundtrip (`HBP_USE_HOST_OSS=1`) not run on this host.

## OSS releases (v0.1.0-alpha)

Tags present on all four public repos; GitHub releases already published:

| Repo | Release URL |
|------|-------------|
| hnf | https://github.com/josiah1203/hnf/releases/tag/v0.1.0-alpha |
| hb-bridge | https://github.com/josiah1203/hb-bridge/releases/tag/v0.1.0-alpha |
| hbw | https://github.com/josiah1203/hbw/releases/tag/v0.1.0-alpha |
| hb | https://github.com/josiah1203/hb/releases/tag/v0.1.0-alpha |

No new `gh release create` required this run.

## Legal / billing

| Doc | Linked from PHASE_0.5 | Status |
|-----|----------------------|--------|
| [`docs/legal/TOS.md`](../legal/TOS.md) | Yes | Stub — legal review pending |
| [`docs/legal/PRIVACY.md`](../legal/PRIVACY.md) | Yes | Stub — legal review pending |
| [`docs/legal/BILLING.md`](../legal/BILLING.md) | Yes | Stub — Stripe/contact-sales TBD |

## Status page + IR

**BLOCKED** — no production URL. Placeholder: [`STATUS_PAGE.md`](STATUS_PAGE.md).

## Runnable vs beta-open

**Runnable gates on this host:** PASS (verify, import harness, OSS releases verified, legal stubs present, release branch).

**Beta-open blockers:** 4h collab soak with live stack, full restore drill, external status page, counsel-approved legal text.
