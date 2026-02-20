// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class RadioCardThemeTokens {
  final Object? enabledCursor;
  final Object? disabledCursor;
  final Object? hoverColor;
  final Object? color;
  final Object? borderWidth;
  final Object? selectedBorderWidth;
  final Object? borderRadius;
  final Object? padding;
  final Object? borderColor;
  final Object? selectedBorderColor;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const RadioCardThemeTokens({
    this.enabledCursor,
    this.disabledCursor,
    this.hoverColor,
    this.color,
    this.borderWidth,
    this.selectedBorderWidth,
    this.borderRadius,
    this.padding,
    this.borderColor,
    this.selectedBorderColor,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const radioCardThemeTokens = RadioCardThemeTokens();

class RadioThemeTokens {
  final Object? activeColor;
  final Object? borderColor;
  final Object? backgroundColor;
  final Object? size;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const RadioThemeTokens({
    this.activeColor,
    this.borderColor,
    this.backgroundColor,
    this.size,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const radioThemeTokens = RadioThemeTokens();
