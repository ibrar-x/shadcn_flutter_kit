// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class DividerThemeDefaults {
  /// Widget fallback: theme.colorScheme.border
  final Object? color;
  final Object? height;

  /// Widget fallback: 1
  final Object? thickness;

  /// Widget fallback: 0
  final Object? indent;

  /// Widget fallback: 0
  final Object? endIndent;
  final Object? padding;

  /// Widget fallback: AxisAlignment.center
  final Object? childAlignment;

  const DividerThemeDefaults({
    this.color,
    this.height,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.padding,
    this.childAlignment,
  });
}
