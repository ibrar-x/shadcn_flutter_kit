# registry_components_manifest.dart

## Purpose
Generates `components.json` and docs snapshot from component metadata and filesystem.

## Script
`tool/registry/registry_components_manifest.dart`

## Command
`dart run tool/registry/registry_components_manifest.dart [options]`

## Options
- `--components <ids>`
- `--set-component-version <v>`
- `--component-version <id=v>` (repeatable)
- `--bump-manifest-version`
- `--set-manifest-version <int>`
- `--force`
- `-h`, `--help`

## Inputs
- Component/composite folders and metadata
- Existing `lib/registry/manifests/components.json`

## Outputs
- `lib/registry/manifests/components.json`
- `docs/assets/registry/components.json` (if present)

## Example
`dart run tool/registry/registry_components_manifest.dart --components button,checkbox --set-component-version 1.2.0`
