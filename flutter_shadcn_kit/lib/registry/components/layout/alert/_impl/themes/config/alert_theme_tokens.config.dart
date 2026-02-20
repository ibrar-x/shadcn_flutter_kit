/// Global token override entrypoint for the alert component.
class AlertThemeTokensConfigGlobalDefaults {
  final Object? padding;
  final Object? backgroundColor;
  final Object? borderColor;

  const AlertThemeTokensConfigGlobalDefaults({
    this.padding,
    this.backgroundColor,
    this.borderColor,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'padding': padding,
    'backgroundColor': backgroundColor,
    'borderColor': borderColor,
  };
}

class AlertThemeTokensConfigGlobalTokens {
  const AlertThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class AlertThemeTokensConfig {
  const AlertThemeTokensConfig._();

  /// Global component theme override for `AlertTheme`.
  static Object? global;
  static const String globalType = 'AlertTheme';
  static const AlertThemeTokensConfigGlobalDefaults globalDefaults =
      AlertThemeTokensConfigGlobalDefaults();
  static const AlertThemeTokensConfigGlobalTokens globalTokens =
      AlertThemeTokensConfigGlobalTokens();
}
