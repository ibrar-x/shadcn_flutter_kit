// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class ScrollbarThemeDefaults {
  final Object? color;
  final Object? thickness;
  final Object? radius;

  const ScrollbarThemeDefaults({
    this.color = '_theme.colorScheme.border',
    this.thickness = '7.0 * _theme.scaling',
    this.radius = 'Radius.circular(_theme.radiusSm)',
  });
}
