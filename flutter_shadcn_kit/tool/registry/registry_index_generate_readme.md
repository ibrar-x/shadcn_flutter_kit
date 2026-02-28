# registry_index_generate.dart

## Purpose
Builds `lib/registry/manifests/index.json` from `components.json` and component metadata.

## Script
`tool/registry/registry_index_generate.dart`

## Command
`dart run tool/registry/registry_index_generate.dart`

## Inputs
- `lib/registry/manifests/components.json`
- Per-component metadata (`meta.json` + optional `<id>.meta.json`)

## Outputs
- `lib/registry/manifests/index.json`

## Notes
- Validates generated index structure before writing.
- Uses canonical metadata path first, then legacy fallback.

## Example
`dart run tool/registry/registry_index_generate.dart`
