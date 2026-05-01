# registry_index_generate.dart

## Purpose
Builds `lib/registry/manifests/index.json` from `components.json` and component metadata.

## Script
`tool/registry/registry_index_generate.dart`

## Command
`dart run tool/registry/registry_index_generate.dart`

## Inputs
- `lib/registry/manifests/components.json`
- Per-component top-level metadata (`meta.json` + optional `<id>.meta.json`)

## Outputs
- `lib/registry/manifests/index.json`

## Notes
- Validates generated index structure before writing.
- Uses component top-level metadata as canonical. Nested `component/registry/` metadata is legacy and should be removed.

## Example
`dart run tool/registry/registry_index_generate.dart`
