// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class DividerThemeTokens {
  final Object? color;
  final Object? height;
  final Object? thickness;
  final Object? indent;
  final Object? endIndent;
  final Object? padding;
  final Object? childAlignment;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const DividerThemeTokens({
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.padding,
    this.childAlignment,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const dividerThemeTokens = DividerThemeTokens();
