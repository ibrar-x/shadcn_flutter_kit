// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class SwitchThemeDefaults {
  final Object? activeColor;
  final Object? inactiveColor;
  final Object? activeThumbColor;
  final Object? inactiveThumbColor;
  final Object? gap;
  final Object? borderRadius;

  const SwitchThemeDefaults({
    this.activeColor = 'theme.colorScheme.primary',
    this.inactiveColor = 'theme.colorScheme.input',
    this.activeThumbColor = 'theme.colorScheme.background',
    this.inactiveThumbColor = 'theme.colorScheme.foreground',
    this.gap = '8 * scaling',
    this.borderRadius = 'BorderRadius.circular(theme.radiusXl)',
  });
}
