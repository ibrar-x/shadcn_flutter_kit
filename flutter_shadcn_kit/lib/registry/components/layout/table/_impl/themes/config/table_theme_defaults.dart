// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class TableThemeDefaults {
  final Object? border;
  final Object? borderRadius;

  /// Widget fallback: appTheme.colorScheme.background
  final Object? backgroundColor;
  final Object? cellTheme;

  const TableThemeDefaults({
    this.border,
    this.borderRadius,
    this.backgroundColor,
    this.cellTheme,
  });
}

class ResizableTableThemeDefaults {
  final Object? tableTheme;

  /// Widget fallback: 4
  final Object? resizerThickness;
  final Object? resizerColor;

  const ResizableTableThemeDefaults({
    this.tableTheme,
    this.resizerThickness = 4,
    this.resizerColor,
  });
}
