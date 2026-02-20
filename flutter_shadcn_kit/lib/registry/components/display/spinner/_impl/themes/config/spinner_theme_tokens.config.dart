/// Global token override entrypoint for the spinner component.
class SpinnerThemeTokensConfigGlobalDefaults {
  final Object? color;
  final Object? size;

  const SpinnerThemeTokensConfigGlobalDefaults({this.color, this.size});

  Map<String, Object?> toMap() => <String, Object?>{
    'color': color,
    'size': size,
  };
}

class SpinnerThemeTokensConfigGlobalTokens {
  const SpinnerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class SpinnerThemeTokensConfig {
  const SpinnerThemeTokensConfig._();

  /// Global component theme override for `SpinnerTheme`.
  static Object? global;
  static const String globalType = 'SpinnerTheme';
  static const SpinnerThemeTokensConfigGlobalDefaults globalDefaults =
      SpinnerThemeTokensConfigGlobalDefaults();
  static const SpinnerThemeTokensConfigGlobalTokens globalTokens =
      SpinnerThemeTokensConfigGlobalTokens();
}
