// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class HoverThemeDefaults {
  final Object? debounceDuration;
  final Object? hitTestBehavior;
  final Object? waitDuration;
  final Object? minDuration;
  final Object? showDuration;

  const HoverThemeDefaults({
    this.debounceDuration = 'const Duration(milliseconds: 100)',
    this.hitTestBehavior = 'HitTestBehavior.deferToChild',
    this.waitDuration = 'const Duration(milliseconds: 500)',
    this.minDuration = 'const Duration(milliseconds: 0)',
    this.showDuration = 'const Duration(milliseconds: 200)',
  });
}
