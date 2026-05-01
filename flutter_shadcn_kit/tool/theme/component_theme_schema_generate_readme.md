# component_theme_schema_generate.dart

## Purpose
Generates per-component `theme.schema.json` from discovered `ComponentThemeData` fields.

## Script
`tool/theme/component_theme_schema_generate.dart`

## Command
`dart run tool/theme/component_theme_schema_generate.dart [options]`

## Options
- `--components <ids>`: comma-separated filter
- `--dry-run`: print targets only
- `-h`, `--help`

## Inputs
- Component Dart theme files
- Component metadata for labels/version context

## Outputs
- Canonical schema:
  - `<component>/theme.schema.json`

## Notes
- Per-component top-level `theme.schema.json` is canonical.
- Nested `<component>/registry/theme.schema.json` copies are legacy and should be removed.

## Example
`dart run tool/theme/component_theme_schema_generate.dart --components button,checkbox`
