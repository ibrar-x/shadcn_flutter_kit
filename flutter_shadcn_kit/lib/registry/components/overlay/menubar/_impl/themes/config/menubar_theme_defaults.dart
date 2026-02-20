// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class MenubarThemeDefaults {
  /// Widget fallback: widget.border
  final Object? border;

  /// Widget fallback: widget.popoverOffset
  final Object? subMenuOffset;
  final Object? padding;

  /// Widget fallback: theme.colorScheme.border
  final Object? borderColor;

  /// Widget fallback: theme.colorScheme.background
  final Object? backgroundColor;

  /// Widget fallback: theme.borderRadiusMd
  final Object? borderRadius;

  const MenubarThemeDefaults({
    this.border,
    this.subMenuOffset,
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
  });
}
