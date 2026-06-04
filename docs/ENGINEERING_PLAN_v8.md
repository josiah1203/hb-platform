# HummingBird Labs Engineering Plan v8 (summary)

Full product spec: *HummingBird Labs Engineering Plan v8* (external). This file tracks **execution phases** grafted from HCP `phase-0.5-beta-rc1` (`e503501631ad23633c0e566f8fe0719204c739d6`).

## Topology

- **Public (Apache 2.0):** `hnf`, `hb-bridge`, `hbw`, `hb`, `hbp-protocol`
- **Private:** `hbp-cloud` (HBP API, HOS, workflow, collab, billing)
- **Meta:** `hb-platform` (agents, verify, worktrees)

HCP monorepo is **archived** — no in-place migration.

## Phase 0 (Week 0–20) — internal alpha

| Milestone | Week | Proof |
|-----------|------|-------|
| M0 | 4 | `hnf` spec public; GPL boundary review; CRDT spike |
| M1 | 10 | HOS API + KiCad/FreeCAD roundtrip |
| M2 | 14 | Phase 0 bridge matrix + workflow v0.1 + `hb` v0.1 |
| M3 | 20 | Semantic merge v0.1 + HBW alpha + integrated demo |

## Phase 0.5 (Week 24–32) — public beta (M4)

Binary gates: 2-week stable alpha, restore drill, 4h collab soak, import &lt;5% loss, status page, legal/billing, **public OSS releases**, public roadmap. Customer-facing name: **HummingBird Platform (HBP)**.

See [`PHASE_0.5.md`](PHASE_0.5.md).

## Phase 1 (Week 28–44) — M5

Parallel workstreams after M4:

- **A (`workflow`):** visual composer, marketplace, webhooks, workflow-minute billing
- **B (`format`+`bridge`+`registry`):** built-env HNF domains, 10 tools, private registry

See [`PHASE_1.md`](PHASE_1.md).

## First agents to spin

`format` + `hos` + `platform` → then `bridge` + `cli` → then `hbw` + `workflow`.
