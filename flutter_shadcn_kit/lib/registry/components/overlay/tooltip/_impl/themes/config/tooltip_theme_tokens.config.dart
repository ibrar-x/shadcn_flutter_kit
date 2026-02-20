/// Global token override entrypoint for the tooltip component.
class TooltipThemeTokensConfigGlobalDefaults {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? padding;
  final Object? backgroundColor;
  final Object? borderRadius;

  const TooltipThemeTokensConfigGlobalDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'surfaceOpacity': surfaceOpacity,
    'surfaceBlur': surfaceBlur,
    'padding': padding,
    'backgroundColor': backgroundColor,
    'borderRadius': borderRadius,
  };
}

class TooltipThemeTokensConfigGlobalTokens {
  const TooltipThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TooltipThemeTokensConfig {
  const TooltipThemeTokensConfig._();

  /// Global component theme override for `TooltipTheme`.
  static Object? global;
  static const String globalType = 'TooltipTheme';
  static const TooltipThemeTokensConfigGlobalDefaults globalDefaults =
      TooltipThemeTokensConfigGlobalDefaults();
  static const TooltipThemeTokensConfigGlobalTokens globalTokens =
      TooltipThemeTokensConfigGlobalTokens();
}
