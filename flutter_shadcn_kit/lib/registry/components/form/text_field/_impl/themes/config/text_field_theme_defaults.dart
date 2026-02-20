// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class TextFieldThemeDefaults {
  /// Widget fallback: compTheme?.borderRadius
  final Object? borderRadius;

  /// Widget fallback: compTheme?.filled ?? false
  final Object? filled;
  final Object? padding;
  final Object? border;

  const TextFieldThemeDefaults({
    this.borderRadius,
    this.filled,
    this.padding,
    this.border,
  });
}
