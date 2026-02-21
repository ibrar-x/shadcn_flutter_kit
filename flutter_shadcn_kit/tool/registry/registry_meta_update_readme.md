# registry_meta_update.dart

## Purpose
Updates existing component `meta.json` files with file lists, dependency info, optional API merge, and version defaults.

## Script
`tool/registry/registry_meta_update.dart`

## Command
`dart run tool/registry/registry_meta_update.dart [options]`

## Options
- `--components <ids>`
- `--set-component-version <v>`
- `--component-version <id=v>` (repeatable)
- `--default-version <v>`
- `-h`, `--help`

## Inputs
- Existing `components.json`
- Component metadata files
- Optional `<id>.meta.json` for API merge

## Outputs
- Updated per-component metadata mirrors:
  - `<component>/registry/meta.json`
  - `<component>/meta.json`

## Example
`dart run tool/registry/registry_meta_update.dart --components button --set-component-version 1.0.1`
