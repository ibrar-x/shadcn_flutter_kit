// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class TrackerThemeDefaults {
  /// Widget fallback: theme.radiusMd
  final Object? radius;

  /// Widget fallback: theme.scaling * 2
  final Object? gap;

  /// Widget fallback: 32
  final Object? itemHeight;

  const TrackerThemeDefaults({this.radius, this.gap, this.itemHeight = 32});
}
