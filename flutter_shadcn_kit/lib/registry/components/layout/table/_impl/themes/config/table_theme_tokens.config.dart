/// Global token override entrypoint for the table component.
class TableThemeTokensConfig {
  const TableThemeTokensConfig._();

  /// Global component theme override for `TableTheme`.
  static Object? global;
  static const String globalType = 'TableTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'border': null,
    'backgroundColor': null,
    'borderRadius': null,
    'cellTheme': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};

  /// Global component theme override for `ResizableTableTheme`.
  static Object? resizableTableTheme;
  static const String resizableTableThemeType = 'ResizableTableTheme';
  static const Map<String, Object?> resizableTableThemeDefaults =
      <String, Object?>{
        'tableTheme': null,
        'resizerThickness': null,
        'resizerColor': null,
      };
  static const Map<String, Object?> resizableTableThemeTokens =
      <String, Object?>{};
}
