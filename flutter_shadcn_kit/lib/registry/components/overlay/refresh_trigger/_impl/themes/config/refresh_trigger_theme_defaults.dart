// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class RefreshTriggerThemeDefaults {
  final Object? minExtent;
  final Object? maxExtent;
  final Object? indicatorBuilder;

  /// Widget fallback: compTheme?.curve ?? Curves.easeOutSine
  final Object? curve;
  final Object? completeDuration;

  const RefreshTriggerThemeDefaults({
    this.minExtent,
    this.maxExtent,
    this.indicatorBuilder,
    this.curve,
    this.completeDuration,
  });
}
