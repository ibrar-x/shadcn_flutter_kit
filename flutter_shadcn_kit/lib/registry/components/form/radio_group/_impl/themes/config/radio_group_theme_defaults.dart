// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
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
  final Object? size;
  final Object? backgroundColor;

  const RadioThemeDefaults({
    this.activeColor,
    this.borderColor,
    this.size,
    this.backgroundColor,
  });
}
