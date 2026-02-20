/// Global token override entrypoint for the divider component.
class DividerThemeTokensConfig {
  const DividerThemeTokensConfig._();

  /// Global component theme override for `DividerTheme`.
  static Object? global;
  static const String globalType = 'DividerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'color': null,
    'height': null,
    'thickness': null,
    'indent': null,
    'endIndent': null,
    'padding': null,
    'childAlignment': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
