# Reuse from HCP (archive)

| Field | Value |
|-------|--------|
| **Tag** | `phase-0.5-beta-rc1` |
| **Commit** | `e503501631ad23633c0e566f8fe0719204c739d6` |
| **Source** | `/Users/josiah/Desktop/HCP_working` |

## Graft map

| Target repo | HCP paths |
|-------------|-----------|
| `hnf` | `adapters/crates/hnf-adapter-sdk` → `crates/hnf-core` |
| `hb-bridge` | `hnf-kicad`, `hnf-freecad`, `rust/crates/sidecar-protocol`, `scripts/regression` |
| `hbp-protocol` | `docs/protocol/jsonrpc/hcp-hos-client.v0.json`, `api/app/services/event_taxonomy.py` |
| `hb` | `cli/hw` → `hb` |
| `hbp-cloud` | `api/`, `infra/pal`, `infra/helm`, `infra/kind`, `docker-compose.yml` |

**Excluded:** `infra/oss-bootstrap/`, `hcp-ide-sidecar` as primary seam, V5 fork workstream.

Refresh: `./scripts/import-from-hcp.sh`
