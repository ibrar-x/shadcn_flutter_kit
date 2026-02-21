# theme_preset_export_one.dart

## Purpose
Exports one Dart-defined theme preset by id.

## Script
`tool/theme/theme_preset_export_one.dart`

## Command
`dart run tool/theme/theme_preset_export_one.dart <theme-id>`

## Inputs
- `<theme-id>` matching preset id in Dart source

## Outputs
- `lib/registry/themes_preset/<theme-id>.json`

## Notes
- Useful for targeted updates without rewriting all preset files.

## Example
`dart run tool/theme/theme_preset_export_one.dart zinc`
