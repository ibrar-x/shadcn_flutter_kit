// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class TableThemeDefaults {
  final Object? border;
  final Object? backgroundColor;
  final Object? borderRadius;
  final Object? cellTheme;

  const TableThemeDefaults({
    this.border,
    this.backgroundColor,
    this.borderRadius,
    this.cellTheme,
  });
}

class ResizableTableThemeDefaults {
  final Object? tableTheme;
  final Object? resizerThickness;
  final Object? resizerColor;

  const ResizableTableThemeDefaults({
    this.tableTheme,
    this.resizerThickness,
    this.resizerColor,
  });
}
