/// Global token override entrypoint for the phone_input component.
class PhoneInputThemeTokensConfigGlobalDefaults {
  final Object? padding;
  final Object? borderRadius;
  final Object? popupConstraints;
  final Object? maxWidth;
  final Object? flagHeight;
  final Object? flagWidth;
  final Object? flagGap;
  final Object? countryGap;
  final Object? flagShape;

  const PhoneInputThemeTokensConfigGlobalDefaults({
    this.padding,
    this.borderRadius,
    this.popupConstraints,
    this.maxWidth,
    this.flagHeight,
    this.flagWidth,
    this.flagGap,
    this.countryGap,
    this.flagShape,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'padding': padding,
    'borderRadius': borderRadius,
    'popupConstraints': popupConstraints,
    'maxWidth': maxWidth,
    'flagHeight': flagHeight,
    'flagWidth': flagWidth,
    'flagGap': flagGap,
    'countryGap': countryGap,
    'flagShape': flagShape,
  };
}

class PhoneInputThemeTokensConfigGlobalTokens {
  const PhoneInputThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class PhoneInputThemeTokensConfig {
  const PhoneInputThemeTokensConfig._();

  /// Global component theme override for `PhoneInputTheme`.
  static Object? global;
  static const String globalType = 'PhoneInputTheme';
  static const PhoneInputThemeTokensConfigGlobalDefaults globalDefaults =
      PhoneInputThemeTokensConfigGlobalDefaults();
  static const PhoneInputThemeTokensConfigGlobalTokens globalTokens =
      PhoneInputThemeTokensConfigGlobalTokens();
}
