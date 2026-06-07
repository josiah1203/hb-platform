# ADR-0002 — HNF interchange tiers (semantic vs geometry vs native)

**Status:** Accepted  
**Date:** 2026-06-06  
**Owners:** `format` + `bridge` (tech-lead sign-off)

## Context

HNF must interoperate with host OSS tools (KiCad, FreeCAD, BlenderBIM, OpenSees, …) without mandating a single geometry kernel. Phase 0 shipped typed domain envelopes with optional `content_hash` blob refs. Phase 1 adds built-environment domains and clarifies how geometry vs semantics cross tool boundaries.

## Decision

Adopt three interchange tiers:

| Tier | Name | Contents | V1 scope |
|------|------|----------|----------|
| **A** | Semantic HNF JSON | Typed domain properties, refs, metadata, constraints | **In scope** — primary interchange |
| **B** | Geometry blobs | STEP (mechanical/MCAD), IFC (BIM), mesh/other by domain | **In scope** — referenced by SHA-256 `content_hash` / `geometry_blobs[]` |
| **C** | Native parametric | Tool-native feature trees (FreeCAD Body, KiCad symbols, …) | **Out of scope** — bridge-internal only |

### Mechanical (MCAD)

- HNF mechanical domain is a **semantic superset** around geometry: solids, materials, tolerances, constraints, boundary conditions, notes.
- Tier B geometry routes through **STEP** blobs stored in HOS; domain JSON carries `content_hash` (envelope) and per-solid `geometry_blobs[]` with `{ format: "step", content_hash }`.
- FreeCAD adapter (`hb-bridge/plugins/freecad/`) wires minimal STEP blob refs on export/import; full tessellation deferred.

### EDA (schematic, layout, ic_layout)

- Tier A carries nets, footprints, symbols; Tier B optional (Gerber, ODB++, mesh previews) via `content_hash`.
- Phase 1: document coverage matrix in bridge READMEs; no new EDA geometry in HNF JSON beyond Phase 0.

### Built environment (bim, geospatial, structural, energy_building)

- Tier A: spatial structure, loads, zones, CRS, schedules.
- Tier B: IFC for BIM, GeoJSON/Shapefile refs for geospatial (via `content_hash`).
- Bridge plugins document honest import/export matrices in `hb-bridge/plugins/phase1/*/README.md`.

## Consequences

- **Positive:** Clear contract for bridge authors; HOS append-only blobs stay canonical for geometry.
- **Positive:** Workflow checks operate on Tier A without loading heavy geometry.
- **Negative:** Roundtrip fidelity depends on host tool STEP/IFC support — tracked per plugin harness.
- **Follow-up:** Tier C native parametric exchange remains a Phase 2+ research item.

## References

- Mechanical schema: `hnf/schemas/domains/mechanical.json`
- Phase 1 domains: `hnf/schemas/domains/{bim,geospatial,structural,energy_building}.json`
- FreeCAD adapter: `hb-bridge/plugins/freecad/hb_bridge.py`
