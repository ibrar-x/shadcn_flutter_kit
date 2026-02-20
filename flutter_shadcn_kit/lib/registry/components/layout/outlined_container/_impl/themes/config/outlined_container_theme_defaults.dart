// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class OutlinedContainerThemeDefaults {
  final Object? backgroundColor;
  final Object? borderColor;
  final Object? borderRadius;
  final Object? borderStyle;
  final Object? borderWidth;
  final Object? boxShadow;
  final Object? padding;
  final Object? surfaceOpacity;
  final Object? surfaceBlur;

  const OutlinedContainerThemeDefaults({
    this.backgroundColor = 'theme.colorScheme.background',
    this.borderColor = 'theme.colorScheme.muted',
    this.borderRadius = 'theme.borderRadiusXl',
    this.borderStyle = 'BorderStyle.solid',
    this.borderWidth = '1.0 * theme.scaling',
    this.boxShadow,
    this.padding = 'EdgeInsets.zero',
    this.surfaceOpacity,
    this.surfaceBlur,
  });
}
