# component_theme_global_configs_generate.dart

## Purpose
Regenerates global component theme config registration file.

## Script
`tool/theme/component_theme_global_configs_generate.dart`

## Command
`dart run tool/theme/component_theme_global_configs_generate.dart`

## Inputs
- Component directories under `lib/registry/components`
- Component theme config classes

## Outputs
- `lib/registry/components/component_theme_global_configs.dart`

## Notes
- Safe to rerun after adding/removing components or changing theme config classes.

## Example
`dart run tool/theme/component_theme_global_configs_generate.dart`
