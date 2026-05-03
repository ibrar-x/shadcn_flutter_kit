# theme_index_generate.dart

## Purpose
Builds the generated theme artifact manifest at
`lib/registry/manifests/theme.index.json` and refreshes the per-theme Dart
install artifacts referenced by that manifest.

## Script
`tool/theme/theme_index_generate.dart`

## Command
`dart run tool/theme/theme_index_generate.dart [--output <filename>]`

## Inputs
- `lib/registry/themes_preset/*.json`

## Options
- `--output <filename>`: output file name (under `lib/registry`)
- `-h`, `--help`

## Outputs
- Default: `lib/registry/manifests/theme.index.json`
- Generated theme artifacts under `lib/registry/shared/theme/generated/<theme>/`

## Example
`dart run tool/theme/theme_index_generate.dart`
