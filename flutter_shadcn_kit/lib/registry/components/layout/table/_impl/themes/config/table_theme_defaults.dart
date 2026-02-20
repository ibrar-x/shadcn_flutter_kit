// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class TableThemeConfigGlobalDefaults {
  final Object? border;
  final Object? backgroundColor;
  final Object? borderRadius;
  final Object? cellTheme;

  const TableThemeConfigGlobalDefaults({
    this.border,
    this.backgroundColor,
    this.borderRadius,
    this.cellTheme,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'border': border,
    'backgroundColor': backgroundColor,
    'borderRadius': borderRadius,
    'cellTheme': cellTheme,
  };
}

class TableThemeConfigResizableTableThemeDefaults {
  final Object? tableTheme;
  final Object? resizerThickness;
  final Object? resizerColor;

  const TableThemeConfigResizableTableThemeDefaults({
    this.tableTheme,
    this.resizerThickness,
    this.resizerColor,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'tableTheme': tableTheme,
    'resizerThickness': resizerThickness,
    'resizerColor': resizerColor,
  };
}

const tableThemeTokensConfigGlobalDefaults = TableThemeConfigGlobalDefaults();
const tableThemeTokensConfigResizableTableThemeDefaults = TableThemeConfigResizableTableThemeDefaults();
