// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class ColorPickerThemeDefaults {
  final Object? spacing;
  final Object? controlSpacing;
  final Object? orientation;
  final Object? enableEyeDropper;
  final Object? sliderSize;

  const ColorPickerThemeDefaults({
    this.spacing = 12.0,
    this.controlSpacing = 8.0,
    this.orientation = 'Axis.vertical',
    this.enableEyeDropper,
    this.sliderSize = 24.0,
  });
}
