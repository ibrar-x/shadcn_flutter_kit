/// Global token override entrypoint for the circular_progress_indicator component.
class CircularProgressIndicatorThemeTokensConfigGlobalDefaults {
  final Object? color;
  final Object? backgroundColor;
  final Object? size;
  final Object? strokeWidth;

  const CircularProgressIndicatorThemeTokensConfigGlobalDefaults({
    this.color,
    this.backgroundColor,
    this.size,
    this.strokeWidth,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'color': color,
    'backgroundColor': backgroundColor,
    'size': size,
    'strokeWidth': strokeWidth,
  };
}

class CircularProgressIndicatorThemeTokensConfigGlobalTokens {
  const CircularProgressIndicatorThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class CircularProgressIndicatorThemeTokensConfig {
  const CircularProgressIndicatorThemeTokensConfig._();

  /// Global component theme override for `CircularProgressIndicatorTheme`.
  static Object? global;
  static const String globalType = 'CircularProgressIndicatorTheme';
  static const CircularProgressIndicatorThemeTokensConfigGlobalDefaults
  globalDefaults = CircularProgressIndicatorThemeTokensConfigGlobalDefaults();
  static const CircularProgressIndicatorThemeTokensConfigGlobalTokens
  globalTokens = CircularProgressIndicatorThemeTokensConfigGlobalTokens();
}
