// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class TextFieldThemeDefaults {
  final Object? border;
  final Object? borderRadius;
  final Object? filled;
  final Object? padding;

  const TextFieldThemeDefaults({
    this.border = 'Border.all( color: theme.colorScheme.border, strokeAlign: BorderSide.strokeAlignCenter, )',
    this.borderRadius,
    this.filled = false,
    this.padding = 'EdgeInsets.symmetric(horizontal: densityContentPadding * 0.75)',
  });
}
