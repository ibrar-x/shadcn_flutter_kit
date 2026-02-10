# Getting Started

This guide covers the typical workflow for generating and validating registry metadata.

## Typical Run Order
1. `dart run ../tool/registry_readme_meta.dart` (optional)
2. `dart run ../tool/registry_meta_update.dart`
3. `dart run ../tool/registry_components_manifest.dart`
4. `dart run ../tool/registry_shared_manifest.dart` (optional)
5. `dart run ../tool/registry_index_generate.dart` (optional)
6. `dart run ../tool/registry_verify.dart`

## Versioning Behavior
- `registry_meta_update.dart` sets `version` to `1.0.0` when missing.
- Existing versions are preserved unless you pass a version flag.
- `registry_components_manifest.dart` copies `version` into `components.json`.

## Manifest Guard
Some scripts protect `manifestVersion`:
- If `manifestVersion > 1`, you must use one of:
  - `--bump-manifest-version`
  - `--set-manifest-version <int>`
  - `--force`

## Help
All scripts support `-h` / `--help` for usage and flags.

## Optional Helpers
- `dart run ../tool/registry_tool.dart init` for interactive component setup.
