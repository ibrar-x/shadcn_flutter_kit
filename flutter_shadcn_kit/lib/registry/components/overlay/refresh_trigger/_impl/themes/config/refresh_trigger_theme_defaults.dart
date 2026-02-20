// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class RefreshTriggerThemeDefaults {
  final Object? minExtent;
  final Object? maxExtent;
  final Object? indicatorBuilder;
  final Object? curve;
  final Object? completeDuration;

  const RefreshTriggerThemeDefaults({
    this.minExtent = '75.0 * theme.scaling',
    this.maxExtent = '150.0 * theme.scaling',
    this.indicatorBuilder = 'RefreshTrigger.defaultIndicatorBuilder',
    this.curve = 'Curves.easeOutSine',
    this.completeDuration = 'const Duration(milliseconds: 500)',
  });
}
