/// Global token override entrypoint for the number_ticker component.
class NumberTickerThemeTokensConfig {
  const NumberTickerThemeTokensConfig._();

  /// Global component theme override for `NumberTickerTheme`.
  static Object? global;
  static const String globalType = 'NumberTickerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'duration': null,
    'curve': null,
    'style': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
