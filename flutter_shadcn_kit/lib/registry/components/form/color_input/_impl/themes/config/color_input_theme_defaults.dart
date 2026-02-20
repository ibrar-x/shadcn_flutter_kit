// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class ColorInputThemeDefaults {
  final Object? showAlpha;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? popoverPadding;
  final Object? mode;
  final Object? pickerMode;
  final Object? enableEyeDropper;
  final Object? showLabel;
  final Object? orientation;
  final Object? showHistory;

  const ColorInputThemeDefaults({
    this.showAlpha = true,
    this.popoverAlignment = 'Alignment.topCenter',
    this.popoverAnchorAlignment = 'Alignment.bottomCenter',
    this.popoverPadding,
    this.mode,
    this.pickerMode,
    this.enableEyeDropper = true,
    this.showLabel = false,
    this.orientation,
    this.showHistory = true,
  });
}
