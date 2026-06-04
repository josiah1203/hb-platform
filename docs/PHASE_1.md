# Phase 1 gate checklist (M5, Week 28–44)

Start only after Phase 0.5 (M4) gates are green.

## Workstream A — workflow cloud

| Week | Deliverable | Owner | Verify |
|------|-------------|-------|--------|
| — | Visual workflow composer (HBW Automation Studio) | hbw + workflow | `make hb-verify-hbw` |
| — | Marketplace API + listing UI | workflow + hbw | `hbp-cloud/packages/workflow/marketplace/` |
| — | Webhooks (Slack, email, JIRA, Linear, HTTP) | workflow | `hbp-cloud/webhooks/README.md` |
| — | Branch protection + sim/AI gate hooks | hos + workflow | stub hooks in workflow engine |
| — | Workflow-minute billing (Stripe) | platform | extends 0.5 billing |

## Workstream B — built environment

| Week | Deliverable | Owner | Verify |
|------|-------------|-------|--------|
| 32 | HNF domains: bim, geospatial, structural, energy_building | format | `hnf/schemas/domains/*.json` |
| 40 | Bridge plugins (BlenderBIM, QGIS, OpenSees, …) | bridge | `hb-bridge/plugins/phase1/README.md` |
| 42 | Built-in workflow checks (IFC, structural, energy) | workflow | `hbp-cloud/packages/workflow/builtins/` |
| 36 | Private component registry (paid orgs) | registry | `hbp-cloud/packages/registry/` |
| 44 | Upstream PRs + Foundation governance doc | devrel + bridge | process doc in hb-platform |

## Parallel verify

```bash
make -C hb-platform hb-verify-parallel   # format, bridge, hos, cli
make -C hb-platform hb-verify-registry     # skips until M5
```

## Exit criteria (M5)

- Workflow cloud mature (composer, marketplace, webhooks, metering)
- Built-environment disciplines live (4 HNF domains, 10 bridge plugins)
- Private registry revenue surface for paid orgs
