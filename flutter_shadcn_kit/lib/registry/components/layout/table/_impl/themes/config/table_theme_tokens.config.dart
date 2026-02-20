/// Global token override entrypoint for the table component.
class TableThemeTokensConfig {
  const TableThemeTokensConfig._();

  /// Global component theme override.
  static Object? global;
  static const String globalType = 'TableTheme';

  /// Global component theme override for `ResizableTableTheme`.
  static Object? resizableTableTheme;
  static const String resizableTableThemeType = 'ResizableTableTheme';
}
