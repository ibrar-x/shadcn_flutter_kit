// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class TextAnimateThemeDefaults {
  final Object? style;
  final Object? typewriter;
  final Object? effect;
  final Object? cursor;

  const TextAnimateThemeDefaults({
    this.style = 'const TextStyle()',
    this.typewriter = 'const TypewriterEffect()',
    this.effect = 'const NoEffect()',
    this.cursor = 'const StreamingCursor.none()',
  });
}
