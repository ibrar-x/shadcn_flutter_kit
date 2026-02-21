# theme_preset_dart_parser.dart

## Purpose
Internal parser utility for reading Dart preset definitions and converting them to schema-compatible JSON structures.

## Script
`tool/theme/theme_preset_dart_parser.dart`

## How it's used
- Imported by:
  - `tool/theme/theme_preset_export_all.dart`
  - `tool/theme/theme_preset_export_one.dart`

## Public helpers
- `findRegistryDir(...)`
- `parseThemePresetsFromDart(...)`
- `withThemeSchema(...)`

## Notes
- This is not intended to be run directly.
- Keep parser behavior aligned with current preset Dart model definitions.
