# registry_sync_all.dart

## Purpose
Full registry sync pass. Rebuilds component entries in `components.json`, refreshes per-component metadata, and updates docs snapshot.

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
- Per-component metadata mirrors:
  - `<component>/registry/meta.json`
  - `<component>/meta.json`

## Notes
- Enforces filtered file lists (excludes README/getting-started/preview and metadata helper files).
- Preserves backward-compatible legacy metadata files while canonical path is `component/registry/*`.

## Example
`dart run tool/registry/registry_sync_all.dart --force`
