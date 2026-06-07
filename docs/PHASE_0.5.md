# Phase 0.5 gate checklist (public beta, M4)

Phase 0.5 is split into two tiers per [ADR-0003](./ADR/0003-m4-local-vs-prod-gates.md):

- **M4-local** — internal beta / dogfooding (100% exit: [`PHASE_0.5_LOCAL_EXIT.md`](./PHASE_0.5_LOCAL_EXIT.md))
- **M4-prod** — external beta-open (pending: [`PHASE_0.5_PROD.md`](./PHASE_0.5_PROD.md))

---

## M4-local gates (internal beta)

All rows must pass for local exit. Verify: `make hb-verify-gates-local`.

| Gate | Owner | Deliverable | Status |
|------|-------|-------------|--------|
| Verify suite | coordinator | `make hb-verify-parallel` + collab + workflow + gates | **PASS** |
| Local API harness | platform | `hbp-cloud/scripts/dev-local.sh` + `seed_dev.py` | **PASS** |
| Collab soak (~2 min) | collab | 120 iter → [`collaboration_soak_local.json`](ops/collaboration_soak_local.json) (`tier: local`) | **PASS** |
| Restore drill (file) | platform + hos | [`local_restore_drill.sh`](https://github.com/hummingbird-labs/hbp-cloud/blob/main/scripts/local_restore_drill.sh) → [`restore_drill_local.md`](ops/restore_drill_local.md) | **PASS** |
| Import &lt;5% loss | hos + bridge | Headless corpus → [`import_loss_local.md`](ops/import_loss_local.md) | **PASS** |
| Status page (local) | platform + devrel | [`docs/status/index.html`](status/index.html) | **PASS** |
| ToS / privacy / billing stubs | devrel | [`docs/legal/`](legal/) — engineering beta-ready | **PASS** |
| Public roadmap | devrel | [`PUBLIC_ROADMAP.md`](./PUBLIC_ROADMAP.md) M4-local 100% | **PASS** |
| Release branch | coordinator | `release/v0.5-beta-local` + CHANGELOG | **PASS** |
| HBW live path | hbw + platform | [`integration_smoke.md`](ops/integration_smoke.md) local quickstart | **PASS** |

**Orchestrator:** `./scripts/run-phase05-local.sh`

---

## M4-prod gates (external beta-open)

Deferred until Docker/kind and external hosting are available. Does not block M4-local exit.

| Gate | Owner | Deliverable | Status |
|------|-------|-------------|--------|
| 2-week stable alpha | coordinator + all | `release/v0.5-beta` + public CHANGELOG | **PENDING** |
| Durability / restore (Postgres) | platform + hos | `hbp-cloud/infra/kind/restore-drill.sh` full drill | **PENDING** |
| 4h collab soak | collab | 14400 iter against compose/kind stack | **PENDING** |
| Import &lt;5% loss (live) | hos + bridge | CI corpus + optional host-tool roundtrip | **PENDING** |
| Status page + IR | platform + devrel | External URL + incident response | **PENDING** |
| ToS / privacy / billing | devrel + legal | Counsel-reviewed pages | **PENDING** |
| Public OSS publish | format, bridge, hbw, cli | GitHub releases per public repo | **PENDING** |
| Public roadmap | devrel | M4-prod 100% in roadmap | **PENDING** |

See [`PHASE_0.5_PROD.md`](./PHASE_0.5_PROD.md) for full prod checklist.

---

## Collab soak reference (local tier)

```bash
cd ~/Desktop/hbp-cloud && ./scripts/dev-local.sh
export HBP_API_URL=http://localhost:8000
export HBP_PROJECT_ID=<project-uuid>
export HBP_EMAIL=admin@dev.hbp HBP_PASSWORD=devpassword
python3 scripts/collaboration_soak.py \
  --iterations 120 --interval-s 1 \
  --tier local --gate m4_local_collab_soak \
  --log-file ../hb-platform/docs/ops/collaboration_soak_local.json
```

**Verify:** `make hb-verify-gates-local` (runs `scripts/phase05-gates.sh` with `PHASE05_TIER=local`).

**Evidence:** [`M4_GATE_RUN.md`](ops/M4_GATE_RUN.md) · collab [`collaboration_soak_local.json`](ops/collaboration_soak_local.json) · restore [`restore_drill_local.md`](ops/restore_drill_local.md) · import [`import_loss_local.md`](ops/import_loss_local.md) · status [`STATUS_PAGE.md`](ops/STATUS_PAGE.md)

**Not at 0.5:** HB Sim cloud, HB AI cloud, enterprise SSO, Phase 1 disciplines (complete — see [`PHASE_1_EXIT.md`](./PHASE_1_EXIT.md)).
