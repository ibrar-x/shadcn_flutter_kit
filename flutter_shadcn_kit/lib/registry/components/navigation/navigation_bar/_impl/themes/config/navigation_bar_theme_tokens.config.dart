/// Global token override entrypoint for the navigation_bar component.
class NavigationBarThemeTokensConfig {
  const NavigationBarThemeTokensConfig._();

  /// Global component theme override for `NavigationBarTheme`.
  static Object? global;
  static const String globalType = 'NavigationBarTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'backgroundColor': null,
    'alignment': null,
    'direction': null,
    'spacing': null,
    'labelType': null,
    'labelPosition': null,
    'labelSize': null,
    'padding': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
