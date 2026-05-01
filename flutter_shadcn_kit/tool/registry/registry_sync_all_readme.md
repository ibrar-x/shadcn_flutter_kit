# registry_sync_all.dart

## Purpose
Full registry sync pass. Rebuilds component entries in `components.json`, refreshes per-component top-level metadata, and updates docs snapshots.

## Script
`tool/registry/registry_sync_all.dart`

## Command
`dart run tool/registry/registry_sync_all.dart [options]`

## Options
- `--bump-manifest-version`
- `--set-manifest-version <int>`
- `--force`
- `-h`, `--help`

## Inputs
- `lib/registry/components/**`
- `lib/registry/composites/**`
- `lib/registry/shared/**`
- Existing `lib/registry/manifests/components.json`

## Outputs
- `lib/registry/manifests/components.json`
- `docs/assets/registry/components.json` (if present)
- Per-component canonical metadata:
  - `<component>/meta.json`
- Docs generated mirror inputs consumed by `docs/lib/ui/shadcn`

## Notes
- Enforces filtered file lists (excludes README/getting-started/preview and metadata helper files).
- Production metadata lives at the component top level: `meta.json`, `<id>.meta.json`, and `theme.schema.json`.
- Nested `component/registry/` metadata directories are legacy and should be removed.
- Run `dart run tool/registry/registry_verify.dart` after sync to confirm manifest, metadata, dependency, and docs snapshot parity.

## Example
`dart run tool/registry/registry_sync_all.dart --force`
