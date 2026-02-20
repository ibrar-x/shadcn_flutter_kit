// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class CardThemeDefaults {
  final Object? padding;
  final Object? filled;
  final Object? fillColor;
  final Object? borderRadius;
  final Object? borderColor;
  final Object? borderWidth;
  final Object? clipBehavior;
  final Object? boxShadow;

  /// Widget fallback: compTheme?.surfaceOpacity ?? theme.surfaceOpacity
  final Object? surfaceOpacity;

  /// Widget fallback: compTheme?.surfaceBlur ?? theme.surfaceBlur
  final Object? surfaceBlur;

  /// Widget fallback: compTheme?.duration
  final Object? duration;

  const CardThemeDefaults({
    this.padding,
    this.filled,
    this.fillColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.clipBehavior,
    this.boxShadow,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.duration,
  });
}
