# Registry Tooling

This folder contains the registry tooling for metadata, manifests, docs, and skill bundles.

Docs live in `tool/docs` and include per-script references plus a getting started guide.

## Getting Started
See `tool/docs/getting-started.md`.

## Scripts (renamed)

### `registry_readme_meta.dart`
Generates `<id>.meta.json` from README.md files (documentation metadata).

### `registry_meta_update.dart`
Updates existing `meta.json` with file lists, dependencies, API, and version (default `1.0.0`).

### `registry_components_manifest.dart`
Generates `components.json` and the docs snapshot, and refreshes shared entries.

### `registry_shared_manifest.dart`
Generates `shared_manifest.json` from `registry/shared`.

### `registry_sync_all.dart`
One-shot sync for meta + components + shared entries.

### `registry_verify.dart`
Validates `components.json` against disk and dependency references.

### `registry_index_generate.dart`
Builds `index.json` from `components.json` + `meta.json` (optionally merges `<id>.meta.json`).

### `registry_skill_bundle.dart`
Creates a registry snapshot bundle for AI skills.

### `registry_tool.dart`
Interactive registry helper for bootstrapping and syncing components.

## Notes
- The tooling **no longer writes `components_1.json`**.
- All scripts support `-h` / `--help` for usage and flags.
