# remove_legacy_component_metadata.dart

## Purpose
Deletes legacy component-root metadata files when canonical `component/registry/*` copies are present.

## Script
`tool/maintenance/remove_legacy_component_metadata.dart`

## Command
`dart run tool/maintenance/remove_legacy_component_metadata.dart [--apply]`

## Modes
- Default: dry-run (prints files that would be deleted)
- `--apply`: actually deletes candidate files

## Files targeted
- `<component>/meta.json`
- `<component>/<id>.meta.json`
- `<component>/theme.schema.json`

## Safety behavior
- File is deleted only if canonical counterpart exists under `<component>/registry/`.
- Missing canonical files are reported as skipped.

## Example
- Preview: `dart run tool/maintenance/remove_legacy_component_metadata.dart`
- Apply: `dart run tool/maintenance/remove_legacy_component_metadata.dart --apply`
