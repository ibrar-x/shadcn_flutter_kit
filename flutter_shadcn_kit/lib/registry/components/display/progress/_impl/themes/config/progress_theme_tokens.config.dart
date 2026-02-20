/// Global token override entrypoint for the progress component.
class ProgressThemeTokensConfigGlobalDefaults {
  final Object? color;
  final Object? backgroundColor;
  final Object? borderRadius;
  final Object? minHeight;

  const ProgressThemeTokensConfigGlobalDefaults({
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.minHeight,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'color': color,
    'backgroundColor': backgroundColor,
    'borderRadius': borderRadius,
    'minHeight': minHeight,
  };
}

class ProgressThemeTokensConfigGlobalTokens {
  const ProgressThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class ProgressThemeTokensConfig {
  const ProgressThemeTokensConfig._();

  /// Global component theme override for `ProgressTheme`.
  static Object? global;
  static const String globalType = 'ProgressTheme';
  static const ProgressThemeTokensConfigGlobalDefaults globalDefaults =
      ProgressThemeTokensConfigGlobalDefaults();
  static const ProgressThemeTokensConfigGlobalTokens globalTokens =
      ProgressThemeTokensConfigGlobalTokens();
}
