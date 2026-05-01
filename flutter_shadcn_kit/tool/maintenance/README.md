# Maintenance Scripts

Repository maintenance and cleanup utilities.

## Scripts

- `remove_legacy_component_metadata.dart`
  - Removes nested legacy `component/registry/` metadata files when production top-level metadata exists.
  - Dry-run by default.
  - Docs: `remove_legacy_component_metadata_readme.md`

## Usage

- Dry run:
  - `dart run tool/maintenance/remove_legacy_component_metadata.dart`
- Apply deletion:
  - `dart run tool/maintenance/remove_legacy_component_metadata.dart --apply`
