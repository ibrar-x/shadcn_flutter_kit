/// Global token override entrypoint for the linear_progress_indicator component.
class LinearProgressIndicatorThemeTokensConfigGlobalDefaults {
  final Object? color;
  final Object? backgroundColor;
  final Object? minHeight;
  final Object? borderRadius;
  final Object? showSparks;
  final Object? disableAnimation;

  const LinearProgressIndicatorThemeTokensConfigGlobalDefaults({
    this.color,
    this.backgroundColor,
    this.minHeight,
    this.borderRadius,
    this.showSparks,
    this.disableAnimation,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'color': color,
    'backgroundColor': backgroundColor,
    'minHeight': minHeight,
    'borderRadius': borderRadius,
    'showSparks': showSparks,
    'disableAnimation': disableAnimation,
  };
}

class LinearProgressIndicatorThemeTokensConfigGlobalTokens {
  const LinearProgressIndicatorThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class LinearProgressIndicatorThemeTokensConfig {
  const LinearProgressIndicatorThemeTokensConfig._();

  /// Global component theme override for `LinearProgressIndicatorTheme`.
  static Object? global;
  static const String globalType = 'LinearProgressIndicatorTheme';
  static const LinearProgressIndicatorThemeTokensConfigGlobalDefaults
  globalDefaults = LinearProgressIndicatorThemeTokensConfigGlobalDefaults();
  static const LinearProgressIndicatorThemeTokensConfigGlobalTokens
  globalTokens = LinearProgressIndicatorThemeTokensConfigGlobalTokens();
}
