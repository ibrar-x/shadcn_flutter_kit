// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class CheckboxThemeDefaults {
  final Object? backgroundColor;
  final Object? activeColor;
  final Object? borderColor;
  final Object? size;
  final Object? gap;
  final Object? borderRadius;

  const CheckboxThemeDefaults({
    this.backgroundColor = 'theme.colorScheme.input.scaleAlpha(0.3)',
    this.activeColor = 'theme.colorScheme.primary',
    this.borderColor = 'theme.colorScheme.border',
    this.size = '16 * scaling',
    this.gap = '8 * scaling',
    this.borderRadius = 'BorderRadius.circular(theme.radiusSm)',
  });
}
