# Import loss evidence (Phase 0.5 — local tier)

## Latest run

| Field | Value |
|-------|--------|
| **Executed (UTC)** | 2026-06-07T04:02:31Z |
| **Tier** | local |
| **Gate** | m4_local_import_loss |
| **Mechanism** | `hb-bridge/scripts/import_loss_report.py` (headless corpus) |
| **Tools exercised** | 23 |
| **Cases** | 23 |
| **Source elements** | 35 |
| **Imported elements** | 35 |
| **Aggregate loss** | 0.00% (limit &lt; 5%) |
| **roundtrip-harness** | PASS |
| **Result** | **PASS** |

## Per-case summary

| Tool | Case | Source | Imported | Loss | OK |
|------|------|--------|----------|------|-----|
| kicad | kicad-minimal-layout | 2 | 2 | 0.0% | yes |
| freecad | freecad-minimal-solid | 1 | 1 | 0.0% | yes |
| klayout | klayout-minimal-gds | 2 | 2 | 0.0% | yes |
| ngspice | ngspice-rc-lowpass | 2 | 2 | 0.0% | yes |
| yosys | yosys-minimal-counter | 2 | 2 | 0.0% | yes |
| verilator | verilator-minimal-tb | 2 | 2 | 0.0% | yes |
| magic | magic-minimal-cell | 2 | 2 | 0.0% | yes |
| openroad | openroad-minimal-flow | 2 | 2 | 0.0% | yes |
| xschem | xschem-minimal-amp | 2 | 2 | 0.0% | yes |
| openems | openems-minimal-patch | 2 | 2 | 0.0% | yes |
| elmer | elmer-minimal-heat | 2 | 2 | 0.0% | yes |
| qucs-s | qucs-s-rc-filter | 2 | 2 | 0.0% | yes |
| platformio | platformio-esp32-env | 2 | 2 | 0.0% | yes |
| blenderbim | blenderbim-minimal | 1 | 1 | 0.0% | yes |
| freecad_bim | freecad_bim-minimal | 1 | 1 | 0.0% | yes |
| openstudio | openstudio-minimal | 1 | 1 | 0.0% | yes |
| qgis | qgis-minimal | 1 | 1 | 0.0% | yes |
| grass | grass-minimal | 1 | 1 | 0.0% | yes |
| openscad | openscad-minimal | 1 | 1 | 0.0% | yes |
| opensees | opensees-minimal | 1 | 1 | 0.0% | yes |
| code_aster | code_aster-minimal | 1 | 1 | 0.0% | yes |
| calculix | calculix-minimal | 1 | 1 | 0.0% | yes |
| librecad | librecad-minimal | 1 | 1 | 0.0% | yes |

