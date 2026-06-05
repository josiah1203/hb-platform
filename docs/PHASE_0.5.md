# Phase 0.5 gate checklist (public beta, M4)

All gates must pass before external beta-open.

| Gate | Owner | Deliverable |
|------|-------|-------------|
| 2-week stable alpha | coordinator + all | Release branch + changelog |
| Durability / restore | platform + hos | Restore drill log — `hbp-cloud/infra/kind/restore-drill.sh` + [`docs/ops/restore_drill_local.md`](ops/restore_drill_local.md) |
| 4h collab soak | collab | Evidence JSON — run `hbp-cloud/scripts/collaboration_soak.py` → `docs/ops/collaboration_soak_local.json` |
| Import &lt;5% loss | hos + bridge | CI corpus KiCad/FreeCAD |
| Status page + IR | platform + devrel | External URL |
| ToS / privacy / billing | devrel + legal | [`docs/legal/TOS.md`](legal/TOS.md), [`docs/legal/PRIVACY.md`](legal/PRIVACY.md), [`docs/legal/BILLING.md`](legal/BILLING.md) |
| Public OSS publish | format, bridge, hbw, cli | GitHub releases per public repo |
| Public roadmap | devrel | `docs/PUBLIC_ROADMAP.md` |

**Not at 0.5:** HB Sim cloud, HB AI cloud, enterprise SSO, Phase 1 disciplines.

## Collab soak reference

```bash
export HBP_API_URL=http://localhost:8000
export HBP_PROJECT_ID=<project-uuid>
export HBP_EMAIL=admin@dev.hbp HBP_PASSWORD=devpassword
python3 ../hbp-cloud/scripts/collaboration_soak.py \
  --iterations 120 --interval-s 1 \
  --log-file docs/ops/collaboration_soak_local.json
```

Verify: `make hb-verify-gates` (runs `scripts/phase05-gates.sh`).

**M4 evidence:** [`docs/ops/M4_GATE_RUN.md`](ops/M4_GATE_RUN.md) · collab [`collaboration_soak_local.json`](ops/collaboration_soak_local.json) · restore [`restore_drill_local.md`](ops/restore_drill_local.md) · status [`STATUS_PAGE.md`](ops/STATUS_PAGE.md)
