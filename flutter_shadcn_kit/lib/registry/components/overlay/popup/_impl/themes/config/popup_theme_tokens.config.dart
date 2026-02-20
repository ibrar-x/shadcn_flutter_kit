/// Global token override entrypoint for the popup component.
class PopupThemeTokensConfigGlobalDefaults {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? padding;
  final Object? fillColor;
  final Object? borderColor;
  final Object? borderRadius;

  const PopupThemeTokensConfigGlobalDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'surfaceOpacity': surfaceOpacity,
    'surfaceBlur': surfaceBlur,
    'padding': padding,
    'fillColor': fillColor,
    'borderColor': borderColor,
    'borderRadius': borderRadius,
  };
}

class PopupThemeTokensConfigGlobalTokens {
  const PopupThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class PopupThemeTokensConfig {
  const PopupThemeTokensConfig._();

  /// Global component theme override for `MenuPopupTheme`.
  static Object? global;
  static const String globalType = 'MenuPopupTheme';
  static const PopupThemeTokensConfigGlobalDefaults globalDefaults =
      PopupThemeTokensConfigGlobalDefaults();
  static const PopupThemeTokensConfigGlobalTokens globalTokens =
      PopupThemeTokensConfigGlobalTokens();
}
