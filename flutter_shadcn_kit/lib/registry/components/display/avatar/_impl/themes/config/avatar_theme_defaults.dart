// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class AvatarThemeDefaults {
  final Object? size;
  final Object? borderRadius;
  final Object? backgroundColor;
  final Object? badgeAlignment;
  final Object? badgeGap;
  final Object? textStyle;

  const AvatarThemeDefaults({
    this.size = 'theme.scaling * 40',
    this.borderRadius = 'theme.radius * size',
    this.backgroundColor = 'theme.colorScheme.muted',
    this.badgeAlignment = 'AlignmentDirectional(offset, offset)',
    this.badgeGap = 'theme.density.baseGap * theme.scaling * gapXs',
    this.textStyle,
  });
}
