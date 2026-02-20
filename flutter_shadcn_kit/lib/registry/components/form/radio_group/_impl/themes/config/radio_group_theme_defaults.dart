// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class RadioCardThemeDefaults {
  final Object? enabledCursor;
  final Object? disabledCursor;
  final Object? hoverColor;
  final Object? color;
  final Object? borderWidth;
  final Object? selectedBorderWidth;
  final Object? borderRadius;
  final Object? padding;
  final Object? borderColor;
  final Object? selectedBorderColor;

  const RadioCardThemeDefaults({
    this.enabledCursor,
    this.disabledCursor,
    this.hoverColor,
    this.color,
    this.borderWidth,
    this.selectedBorderWidth,
    this.borderRadius,
    this.padding,
    this.borderColor,
    this.selectedBorderColor,
  });
}

class RadioThemeDefaults {
  final Object? activeColor;
  final Object? borderColor;
  final Object? backgroundColor;
  final Object? size;

  const RadioThemeDefaults({
    this.activeColor,
    this.borderColor,
    this.backgroundColor,
    this.size,
  });
}
