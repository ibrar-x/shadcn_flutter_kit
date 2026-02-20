// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class TableThemeTokens {
  final Object? border;
  final Object? borderRadius;
  final Object? backgroundColor;
  final Object? cellTheme;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const TableThemeTokens({
    this.border,
    this.borderRadius,
    this.backgroundColor,
    this.cellTheme,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const tableThemeTokens = TableThemeTokens();

class ResizableTableThemeTokens {
  final Object? tableTheme;
  final Object? resizerThickness;
  final Object? resizerColor;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const ResizableTableThemeTokens({
    this.tableTheme,
    this.resizerThickness,
    this.resizerColor,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const resizableTableThemeTokens = ResizableTableThemeTokens();
