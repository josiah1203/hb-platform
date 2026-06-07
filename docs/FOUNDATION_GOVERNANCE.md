# Foundation governance (HummingBird Labs v8)

**Status:** Adopted Phase 1 (M5) · **Owner:** devrel + bridge

## Purpose

Govern upstream contributions to host OSS tools (KiCad, FreeCAD, BlenderBIM, OpenSees, …) and community workflow marketplace listings under the HummingBird Foundation model.

## Principles

1. **Upstream first** — prefer PRs to host tools over proprietary forks.
2. **Tier A interchange** — HNF JSON semantic layer is the public contract (ADR-0002).
3. **Honest coverage** — bridge READMEs document import/export matrices; no overclaiming roundtrip fidelity.
4. **Paid registry isolation** — private component registry is org-scoped and paid-plan gated.

## Phase 1 upstream obligations

| Tool | Domain | PR doc | Target |
|------|--------|--------|--------|
| BlenderBIM | bim | [`hb-bridge/docs/upstream/blenderbim.md`](../../hb-bridge/docs/upstream/blenderbim.md) | IFC HNF sidecar export |
| FreeCAD BIM | bim | [`freecad_bim.md`](../../hb-bridge/docs/upstream/freecad_bim.md) | BIM workbench HNF hook |
| OpenStudio | energy_building | [`openstudio.md`](../../hb-bridge/docs/upstream/openstudio.md) | IDF semantic mapping |
| QGIS | geospatial | [`qgis.md`](../../hb-bridge/docs/upstream/qgis.md) | Layer metadata export |
| GRASS GIS | geospatial | [`grass.md`](../../hb-bridge/docs/upstream/grass.md) | Raster/vector refs |
| OpenSCAD | mechanical | [`openscad.md`](../../hb-bridge/docs/upstream/openscad.md) | Solid parametric stub |
| OpenSees | structural | [`opensees.md`](../../hb-bridge/docs/upstream/opensees.md) | FEA model exchange |
| Code_Aster | structural | [`code_aster.md`](../../hb-bridge/docs/upstream/code_aster.md) | Analysis deck refs |
| CalculiX | structural | [`calculix.md`](../../hb-bridge/docs/upstream/calculix.md) | FE input mapping |
| LibreCAD | layout | [`librecad.md`](../../hb-bridge/docs/upstream/librecad.md) | 2D DXF layer stub |

## Marketplace governance

- Community checks require `editor` role to publish.
- Checks must declare domain and target HNF schema version.
- Malicious or license-incompatible listings: report to `security@hummingbird.dev`.

## Decision log

- ADR-0002 interchange tiers accepted 2026-06-06.
- Private registry gated on `paid_plan` org metadata (Phase 1 stub).
