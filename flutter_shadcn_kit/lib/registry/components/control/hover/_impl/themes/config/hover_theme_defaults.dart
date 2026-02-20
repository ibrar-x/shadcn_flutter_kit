// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class HoverThemeDefaults {
  final Object? debounceDuration;
  final Object? hitTestBehavior;

  /// Widget fallback: const Duration(milliseconds: 500
  final Object? waitDuration;

  /// Widget fallback: const Duration(milliseconds: 0
  final Object? minDuration;

  /// Widget fallback: const Duration(milliseconds: 200
  final Object? showDuration;

  const HoverThemeDefaults({
    this.debounceDuration,
    this.hitTestBehavior,
    this.waitDuration,
    this.minDuration,
    this.showDuration,
  });
}
