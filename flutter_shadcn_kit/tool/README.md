# Tooling Layout

Tool scripts are grouped by purpose:

- `tool/registry/`
  - Registry metadata/manifests/index/verification and bootstrap tooling.
- `tool/theme/`
  - Theme schema/index/config generation and preset exports.
- `tool/refactor/`
  - Migration/refactor scripts.
- `tool/maintenance/`
  - Cleanup and maintenance utilities.
- `tool/common/`
  - Shared helpers used by scripts in other folders.

Each folder includes a local `README.md` describing scripts and run commands.

## Docs

Legacy per-script docs are still available in:

- `tool/docs/`
