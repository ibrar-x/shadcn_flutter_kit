// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class AvatarThemeDefaults {
  /// Widget fallback: theme.scaling * 40
  final Object? size;

  /// Widget fallback: theme.radius * size
  final Object? borderRadius;
  final Object? backgroundColor;
  final Object? badgeAlignment;
  final Object? badgeGap;
  final Object? textStyle;

  const AvatarThemeDefaults({
    this.size,
    this.borderRadius,
    this.backgroundColor,
    this.badgeAlignment,
    this.badgeGap,
    this.textStyle,
  });
}
