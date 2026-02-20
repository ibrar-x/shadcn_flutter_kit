// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class TooltipThemeDefaults {
  /// Widget fallback: compTheme?.surfaceOpacity
  final Object? surfaceOpacity;

  /// Widget fallback: compTheme?.surfaceBlur
  final Object? surfaceBlur;
  final Object? padding;
  final Object? backgroundColor;
  final Object? borderRadius;

  const TooltipThemeDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
  });
}
