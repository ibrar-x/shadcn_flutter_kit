/// Global token override entrypoint for the table component.
class TableThemeTokensConfigGlobalDefaults {
  final Object? border;
  final Object? backgroundColor;
  final Object? borderRadius;
  final Object? cellTheme;

  const TableThemeTokensConfigGlobalDefaults({
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

class TableThemeTokensConfigGlobalTokens {
  const TableThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TableThemeTokensConfigResizableTableThemeDefaults {
  final Object? tableTheme;
  final Object? resizerThickness;
  final Object? resizerColor;

  const TableThemeTokensConfigResizableTableThemeDefaults({
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

class TableThemeTokensConfigResizableTableThemeTokens {
  const TableThemeTokensConfigResizableTableThemeTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TableThemeTokensConfig {
  const TableThemeTokensConfig._();

  /// Global component theme override for `TableTheme`.
  static Object? global;
  static const String globalType = 'TableTheme';
  static const TableThemeTokensConfigGlobalDefaults globalDefaults =
      TableThemeTokensConfigGlobalDefaults();
  static const TableThemeTokensConfigGlobalTokens globalTokens =
      TableThemeTokensConfigGlobalTokens();

  /// Global component theme override for `ResizableTableTheme`.
  static Object? resizableTableTheme;
  static const String resizableTableThemeType = 'ResizableTableTheme';
  static const TableThemeTokensConfigResizableTableThemeDefaults
  resizableTableThemeDefaults =
      TableThemeTokensConfigResizableTableThemeDefaults();
  static const TableThemeTokensConfigResizableTableThemeTokens
  resizableTableThemeTokens = TableThemeTokensConfigResizableTableThemeTokens();
}
