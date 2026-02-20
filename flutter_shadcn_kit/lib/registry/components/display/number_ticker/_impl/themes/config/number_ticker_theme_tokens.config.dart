/// Global token override entrypoint for the number_ticker component.
class NumberTickerThemeTokensConfigGlobalDefaults {
  final Object? duration;
  final Object? curve;
  final Object? style;

  const NumberTickerThemeTokensConfigGlobalDefaults({
    this.duration,
    this.curve,
    this.style,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'duration': duration,
    'curve': curve,
    'style': style,
  };
}

class NumberTickerThemeTokensConfigGlobalTokens {
  const NumberTickerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class NumberTickerThemeTokensConfig {
  const NumberTickerThemeTokensConfig._();

  /// Global component theme override for `NumberTickerTheme`.
  static Object? global;
  static const String globalType = 'NumberTickerTheme';
  static const NumberTickerThemeTokensConfigGlobalDefaults globalDefaults =
      NumberTickerThemeTokensConfigGlobalDefaults();
  static const NumberTickerThemeTokensConfigGlobalTokens globalTokens =
      NumberTickerThemeTokensConfigGlobalTokens();
}
