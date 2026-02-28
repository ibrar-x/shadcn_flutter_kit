# registry_shared_manifest.dart

## Purpose
Generates `lib/registry/shared/shared_manifest.json` from `registry/shared` usage in `components.json`.

## Script
`tool/registry/registry_shared_manifest.dart`

## Command
`dart run tool/registry/registry_shared_manifest.dart [options]`

## Options
- `--bump-manifest-version`
- `--set-manifest-version <int>`
- `--force`
- `-h`, `--help`

## Inputs
- `lib/registry/shared/**`
- `lib/registry/manifests/components.json`

## Outputs
- `lib/registry/shared/shared_manifest.json`

## Example
`dart run tool/registry/registry_shared_manifest.dart --force`
