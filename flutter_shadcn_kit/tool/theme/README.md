# Theme Scripts

Scripts for theme schema/index/config generation and exports.

## Scripts

- `component_theme_schema_generate.dart`
  - Generates per-component `registry/theme.schema.json` files.
  - Command: `dart run tool/theme/component_theme_schema_generate.dart`
  - Docs: `component_theme_schema_generate_readme.md`
- `component_theme_global_configs_generate.dart`
  - Regenerates global component theme config registration.
  - Command: `dart run tool/theme/component_theme_global_configs_generate.dart`
  - Docs: `component_theme_global_configs_generate_readme.md`
- `theme_index_generate.dart`
  - Generates `lib/registry/manifests/theme.index.json`.
  - Command: `dart run tool/theme/theme_index_generate.dart`
  - Docs: `theme_index_generate_readme.md`
- `theme_preset_dart_parser.dart`
  - Parser utility for theme preset extraction.
  - Docs: `theme_preset_dart_parser_readme.md`
- `theme_preset_export_all.dart`
  - Exports all presets.
  - Command: `dart run tool/theme/theme_preset_export_all.dart`
  - Docs: `theme_preset_export_all_readme.md`
- `theme_preset_export_one.dart`
  - Exports a single preset.
  - Command: `dart run tool/theme/theme_preset_export_one.dart <theme-id>`
  - Docs: `theme_preset_export_one_readme.md`

## Help

Use `-h` or `--help` on supported scripts.
