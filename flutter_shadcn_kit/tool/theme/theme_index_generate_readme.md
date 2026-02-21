# theme_index_generate.dart

## Purpose
Builds `lib/registry/theme.index.json` from preset theme JSON files.

## Script
`tool/theme/theme_index_generate.dart`

## Command
`dart run tool/theme/theme_index_generate.dart [--default <id>] [--output <filename>]`

## Inputs
- `lib/registry/themes_preset/*.json`

## Options
- `--default <id>`: default theme id
- `--output <filename>`: output file name (under `lib/registry`)
- `-h`, `--help`

## Outputs
- Default: `lib/registry/theme.index.json`

## Example
`dart run tool/theme/theme_index_generate.dart --default zinc`
