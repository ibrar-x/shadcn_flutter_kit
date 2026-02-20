/// Global token override entrypoint for the card component.
class CardThemeTokensConfigGlobalDefaults {
  final Object? padding;
  final Object? filled;
  final Object? fillColor;
  final Object? borderRadius;
  final Object? borderColor;
  final Object? borderWidth;
  final Object? clipBehavior;
  final Object? boxShadow;
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? duration;

  const CardThemeTokensConfigGlobalDefaults({
    this.padding,
    this.filled,
    this.fillColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.clipBehavior,
    this.boxShadow,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.duration,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'padding': padding,
    'filled': filled,
    'fillColor': fillColor,
    'borderRadius': borderRadius,
    'borderColor': borderColor,
    'borderWidth': borderWidth,
    'clipBehavior': clipBehavior,
    'boxShadow': boxShadow,
    'surfaceOpacity': surfaceOpacity,
    'surfaceBlur': surfaceBlur,
    'duration': duration,
  };
}

class CardThemeTokensConfigGlobalTokens {
  const CardThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class CardThemeTokensConfig {
  const CardThemeTokensConfig._();

  /// Global component theme override for `CardTheme`.
  static Object? global;
  static const String globalType = 'CardTheme';
  static const CardThemeTokensConfigGlobalDefaults globalDefaults =
      CardThemeTokensConfigGlobalDefaults();
  static const CardThemeTokensConfigGlobalTokens globalTokens =
      CardThemeTokensConfigGlobalTokens();
}
