# theme_preset_json_to_dart.dart

## Purpose
Converts **one selected** theme preset JSON into a Dart preset object file for CLI theme installation.

It does all of the following in one run:
- Generates one Dart file for the selected preset (for example, `amber_minimal.dart`).
- Generates/updates `theme_preset_models.dart` (shared preset model classes).
- Updates `app_theme_preset.dart` to import and select the generated preset variable.
- Updates `app_theme.dart` imports to use generated models instead of `preset_themes.dart`.
- Optionally deletes legacy `preset_themes.dart`.

## Default Paths
- Input JSON dir:
  - `lib/registry/themes_preset`
- Output per-theme Dart dir:
  - `lib/registry/shared/theme/presets`
- Generated model file:
  - `lib/registry/shared/theme/theme_preset_models.dart`
- Updated app preset file:
  - `lib/registry/shared/theme/app_theme_preset.dart`
- Updated app theme file:
  - `lib/registry/shared/theme/app_theme.dart`
- Legacy file (optional delete):
  - `lib/registry/shared/theme/preset_themes.dart`

## Usage
From `flutter_shadcn_kit/`:

```bash
dart run tool/theme/theme_preset_json_to_dart.dart --preset-id=amber-minimal
```

## Required Selection
You must pass one of:
- `--preset-id=<id>`
- `--preset-json=<absolute-or-relative-path>`

## Flags
- `--input-dir=<path>`: source JSON directory.
- `--output-dir=<path>`: where the generated preset Dart file is written.
- `--preset-id=<id>`: selected preset id; reads `<input-dir>/<id>.json`.
- `--preset-json=<path>`: explicit selected preset JSON file path.
- `--models-path=<path>`: output path for `theme_preset_models.dart`.
- `--app-theme-preset-path=<path>`: output path for `app_theme_preset.dart`.
- `--app-theme-path=<path>`: file to patch imports in `app_theme.dart`.
- `--legacy-preset-path=<path>`: legacy monolith file path.
- `--delete-legacy=<true|false>`: delete legacy `preset_themes.dart` (default `true`).

## Example
```bash
dart run tool/theme/theme_preset_json_to_dart.dart \
  --input-dir=lib/registry/themes_preset \
  --output-dir=lib/registry/shared/theme/presets \
  --preset-id=amber-minimal \
  --delete-legacy=true
```

## Notes
- The script intentionally generates only the selected preset file to match CLI install flow.
- Re-run the script whenever the selected preset JSON changes.
