# remove_legacy_component_metadata.dart

## Purpose
Deletes nested legacy `component/registry/*` metadata files when canonical component top-level metadata is present.

## Script
`tool/maintenance/remove_legacy_component_metadata.dart`

## Command
`dart run tool/maintenance/remove_legacy_component_metadata.dart [--apply]`

## Modes
- Default: dry-run (prints files that would be deleted)
- `--apply`: actually deletes candidate files

## Files targeted
- `<component>/registry/meta.json`
- `<component>/registry/<id>.meta.json`
- `<component>/registry/theme.schema.json`

## Safety behavior
- A legacy file is deleted only if its canonical counterpart exists at the component top level.
- Missing top-level canonical files are reported as skipped.

## Example
- Preview: `dart run tool/maintenance/remove_legacy_component_metadata.dart`
- Apply: `dart run tool/maintenance/remove_legacy_component_metadata.dart --apply`
