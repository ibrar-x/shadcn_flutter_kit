// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class OutlinedContainerThemeDefaults {
  final Object? backgroundColor;
  final Object? borderColor;

  /// Widget fallback: theme.borderRadiusLg
  final Object? borderRadius;
  final Object? borderStyle;
  final Object? borderWidth;
  final Object? boxShadow;
  final Object? padding;
  final Object? surfaceOpacity;
  final Object? surfaceBlur;

  const OutlinedContainerThemeDefaults({
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderStyle,
    this.borderWidth,
    this.boxShadow,
    this.padding,
    this.surfaceOpacity,
    this.surfaceBlur,
  });
}
