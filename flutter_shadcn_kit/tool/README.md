# Tooling Layout

Tool scripts are grouped by purpose:

- `tool/registry/`
  - Registry metadata/manifests/index/verification and bootstrap tooling.
- `tool/theme/`
  - Theme schema/index/config generation and preset exports.
- `tool/maintenance/`
  - Cleanup and maintenance utilities.
- `tool/common/`
  - Shared helpers used by scripts in other folders.

Each folder includes:

- A local `README.md` index
- Detailed per-script docs named `scriptname_readme.md`

## Docs

Legacy per-script docs are still available in:

- `tool/docs/`
