# Single-File Component Theme Replacement Plan

## 1) Objective
Enable per-component theming with **one replaceable file per component**.

User flow:
1. Customize one component on website (example: Button).
2. Download/copy generated config Dart for that component.
3. Replace one file in repo.
4. Theme applies globally for that component with no widget edits.

## 2) Success Criteria
- Every themeable component has exactly one canonical replaceable file:
  - `_impl/themes/config/*_theme_tokens.config.dart`
- File contains:
  - theme type ids
  - default values currently used by runtime
  - customizable token values/overrides
- Runtime resolves component visuals from this contract order only:
  1. widget instance override
  2. scoped `ComponentTheme` (optional)
  3. component config override (`*_theme_tokens.config.dart`)
  4. component config defaults
- No hidden fallback defaults remain in widget/state code for fields represented in config.

## 3) Current State (as of now)
- 3-layer structure exists (`base/variants/config`) for component themes.
- Config files exist for all targeted components.
- Global registration exists for component configs.
- Partial extraction of defaults from runtime fallback logic has been done.
- Gap: some defaults still live only inside widget/state fallback logic and are not yet fully canonicalized in config.

## 4) Final Contract Per Component
For each component `X`, keep:
1. `base/*_theme.dart` (theme data types)
2. `variants/*.dart` (if needed)
3. `config/x_theme_tokens.config.dart` (single replaceable entrypoint)

### Config File Contract
Each config entry should include:
- `...Type` (stable type key)
- `...Defaults` (resolved default values)
- `...Tokens` (customizable values to override defaults)
- optional typed override object for components with strict types (like Button variants)

Example shape:
```dart
static const String globalType = 'CheckboxTheme';
static const Map<String, Object?> globalDefaults = <String, Object?>{
  'size': '16 * scaling',
  'gap': '8 * scaling',
};
static const Map<String, Object?> globalTokens = <String, Object?>{};
```

## 5) Runtime Resolution (Mandatory)
For each component field `f`:
- `resolved.f = widget.f ?? scopedTheme.f ?? configToken.f ?? configDefault.f`

Policy:
- If `f` is present in config schema, widget/state code must not add a separate fallback constant.
- All fallback values must trace to config defaults.

## 6) Website Generator Contract
Website output for one component must be directly replaceable into that component config file.

### Inputs
- component schema (`component_theme.schema.json` + component-specific metadata)
- existing config file contract

### Outputs
- fully-formed `*_theme_tokens.config.dart` for one component
- preserves keys and type ids
- modifies only `...Tokens` (and optionally explicit override objects) unless explicitly regenerating defaults

### Replaceability Rule
Generated file must compile alone when replacing existing config file.

## 7) Default Extraction Strategy
To complete migration safely:
1. Build a field map per component from config keys.
2. Trace fallback sources in widget/state/theme constructors.
3. Move canonical fallback values into `...Defaults`.
4. Remove duplicated fallback literals in widget/state for those fields.
5. Keep unresolved dynamic expressions as explicit expression strings.

## 8) Batch Execution Plan

### Batch A: Contract Lock
- Freeze config file schema and naming conventions.
- Define mandatory fields for each config entry.
- Add lint/check script to enforce shape.

### Batch B: Default Canonicalization (Core Components First)
- Control: button, hover, scrollbar
- Form: text_field, select, slider, checkbox, switch, etc.
- Move remaining hidden defaults into config defaults.

### Batch C: Display + Layout
- Apply same migration for display/layout components.
- Remove stale fallback literals from widget/state where keys exist in config.

### Batch D: Navigation + Overlay + Utility
- Complete remaining groups.
- Standardize variant handling (tabs, menu/menubar, button-like variant sets).

### Batch E: Generator + Validation
- Finalize website generator template.
- Add CI checks:
  - config completeness
  - key/type stability
  - compile check after single-file replacement simulation.

## 9) Validation Checklist
For every component:
- Replacing only `*_theme_tokens.config.dart` changes visuals.
- No compile errors after replace.
- Analyzer clean (excluding known non-blocking repo info lints).
- Preview/snapshot confirms field changes map correctly.

## 10) Risks and Mitigations
- Risk: dynamic defaults depend on runtime context (`theme`, `scaling`, density).
  - Mitigation: store as expression strings and resolve centrally.
- Risk: variants drift from main component defaults.
  - Mitigation: one config file per component owns all variant entries.
- Risk: generator output drift from runtime schema.
  - Mitigation: schema versioning + CI schema compatibility test.

## 11) Deliverables
1. Stable config contract documentation.
2. Fully canonical defaults in config files for all themeable component fields.
3. Runtime fallback cleanup aligned to config-only defaults.
4. Website generator template for per-component replaceable config file.
5. CI checks for one-file replacement guarantee.

## 12) Definition of Done
Project is done when any component (example: Button) can be themed by replacing only:
- `.../components/<group>/<component>/_impl/themes/config/<component>_theme_tokens.config.dart`

and that replacement alone updates component theme across the app.
