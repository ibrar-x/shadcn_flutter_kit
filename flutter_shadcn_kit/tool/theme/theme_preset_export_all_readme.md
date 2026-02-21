# theme_preset_export_all.dart

## Purpose
Exports all Dart-defined theme presets to JSON files.

## Script
`tool/theme/theme_preset_export_all.dart`

## Command
`dart run tool/theme/theme_preset_export_all.dart`

## Inputs
- Source presets from Dart definitions (via parser helper)

## Outputs
- `lib/registry/themes_preset/*.json` (one file per preset)

## Notes
- Use after changing preset definitions in Dart source.

## Example
`dart run tool/theme/theme_preset_export_all.dart`
