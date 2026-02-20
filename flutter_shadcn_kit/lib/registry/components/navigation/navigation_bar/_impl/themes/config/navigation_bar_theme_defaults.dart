// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class NavigationBarThemeDefaults {
  final Object? backgroundColor;

  /// Widget fallback: Alignment.center
  final Object? alignment;

  /// Widget fallback: Axis.vertical
  final Object? direction;

  /// Widget fallback: (theme.density.baseGap * scaling
  final Object? spacing;
  final Object? labelType;
  final Object? labelPosition;
  final Object? labelSize;
  final Object? padding;

  const NavigationBarThemeDefaults({
    this.backgroundColor,
    this.alignment,
    this.direction,
    this.spacing,
    this.labelType,
    this.labelPosition,
    this.labelSize,
    this.padding,
  });
}
