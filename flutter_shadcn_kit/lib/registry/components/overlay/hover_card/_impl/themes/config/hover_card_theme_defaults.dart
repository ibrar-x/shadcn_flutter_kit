// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class HoverCardThemeDefaults {
  final Object? debounce;
  final Object? wait;
  final Object? popoverAlignment;
  final Object? anchorAlignment;
  final Object? popoverOffset;
  final Object? behavior;

  const HoverCardThemeDefaults({
    this.debounce = 'const Duration(milliseconds: 500)',
    this.wait = 'const Duration(milliseconds: 500)',
    this.popoverAlignment = 'Alignment.topCenter',
    this.anchorAlignment = 'Alignment.bottomCenter',
    this.popoverOffset = 'const Offset(0, 8)',
    this.behavior = 'HitTestBehavior.deferToChild',
  });
}
