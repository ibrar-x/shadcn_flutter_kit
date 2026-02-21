# Refactor Scripts

One-off or migration-focused scripts used during large refactors.

## Scripts

- `rewrite_component_theme_templates.dart`
  - Rewrites component theme templates to target architecture.
- `refactor_preset_themes.dart`
  - Refactors theme preset structures.
- `refactor_presets_to_factories.dart`
  - Converts preset declarations to factory form.
- `refactor_presets.py`
  - Python-based preset refactor helper.

## Usage

Run only when performing explicit migrations/refactors.

Examples:

- `dart run tool/refactor/rewrite_component_theme_templates.dart`
- `dart run tool/refactor/refactor_preset_themes.dart`
- `dart run tool/refactor/refactor_presets_to_factories.dart`
- `python3 tool/refactor/refactor_presets.py`
