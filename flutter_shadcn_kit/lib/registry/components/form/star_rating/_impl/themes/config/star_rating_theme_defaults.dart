// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class StarRatingThemeDefaults {
  final Object? activeColor;
  final Object? backgroundColor;
  final Object? starSize;
  final Object? starSpacing;

  const StarRatingThemeDefaults({
    this.activeColor = '_enabled ? theme.colorScheme.primary : theme.colorScheme.mutedForeground',
    this.backgroundColor = 'theme.colorScheme.muted',
    this.starSize = 24.0,
    this.starSpacing = '5.0 * scaling',
  });
}
