# Theme Scripts

Scripts for theme schema/index/config generation and exports.

## Scripts

- `component_theme_schema_generate.dart`
  - Generates per-component `registry/theme.schema.json` files.
  - Command: `dart run tool/theme/component_theme_schema_generate.dart`
- `component_theme_global_configs_generate.dart`
  - Regenerates global component theme config registration.
  - Command: `dart run tool/theme/component_theme_global_configs_generate.dart`
- `theme_index_generate.dart`
  - Generates `lib/registry/theme.index.json`.
  - Command: `dart run tool/theme/theme_index_generate.dart`
- `theme_preset_dart_parser.dart`
  - Parser utility for theme preset extraction.
- `theme_preset_export_all.dart`
  - Exports all presets.
  - Command: `dart run tool/theme/theme_preset_export_all.dart`
- `theme_preset_export_one.dart`
  - Exports a single preset.
  - Command: `dart run tool/theme/theme_preset_export_one.dart <theme-id>`

## Help

Use `-h` or `--help` on supported scripts.
