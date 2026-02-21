# Maintenance Scripts

Repository maintenance and cleanup utilities.

## Scripts

- `remove_legacy_component_metadata.dart`
  - Removes legacy component-root metadata files only when canonical copies exist under `component/registry/`.
  - Dry-run by default.

## Usage

- Dry run:
  - `dart run tool/maintenance/remove_legacy_component_metadata.dart`
- Apply deletion:
  - `dart run tool/maintenance/remove_legacy_component_metadata.dart --apply`
