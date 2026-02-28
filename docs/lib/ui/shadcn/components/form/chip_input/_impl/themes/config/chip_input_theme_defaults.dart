// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in chip input widgets
// ═══════════════════════════════════════════════════════════

class ChipInputThemeDefaults {
  const ChipInputThemeDefaults({this.useChips = true, this.spacing = 4.0});

  /// From `ChipInputState`: `defaultValue: true`
  final bool useChips;

  /// From `ChipEditingController`: `theme?.spacing ?? 4.0`
  final double spacing;
}
