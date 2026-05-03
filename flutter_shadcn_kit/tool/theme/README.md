# Theme Scripts

Scripts for theme schema/index/config generation and exports.

## Production Layout

- Per-component top-level `theme.schema.json` files are canonical.
- Nested component `registry/theme.schema.json` files are legacy compatibility artifacts and should be removed.
- Run registry sync and verify after schema changes:
  - `dart run tool/registry/registry_sync_all.dart --force`
  - `dart run tool/registry/registry_verify.dart`

## Scripts

- `component_theme_schema_generate.dart`
  - Generates per-component top-level `theme.schema.json` files.
  - Command: `dart run tool/theme/component_theme_schema_generate.dart`
  - Docs: `component_theme_schema_generate_readme.md`
- `component_theme_global_configs_generate.dart`
  - Regenerates global component theme config registration.
  - Command: `dart run tool/theme/component_theme_global_configs_generate.dart`
  - Docs: `component_theme_global_configs_generate_readme.md`
- `theme_index_generate.dart`
  - Generates the hashed theme artifact manifest at
    `lib/registry/manifests/theme.index.json`.
  - Refreshes generated per-theme install artifacts under
    `lib/registry/shared/theme/generated/`.
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

## Theme artifact contract

- `theme.index.json` now publishes generated install artifacts, not raw preset
  JSON pointers.
- Theme artifact entries contain `name`, `label`, optional `description`,
  optional `source`, and `files[]` with `source`, `target`, and `sha256`.
- Runtime CLI execution semantics are not supported by
  `theme_preset_json_to_dart.dart`.
