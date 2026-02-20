// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class SwitchThemeTokens {
  final Object? activeColor;
  final Object? inactiveColor;
  final Object? activeThumbColor;
  final Object? inactiveThumbColor;
  final Object? gap;
  final Object? borderRadius;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const SwitchThemeTokens({
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.gap,
    this.borderRadius,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const switchThemeTokens = SwitchThemeTokens();
