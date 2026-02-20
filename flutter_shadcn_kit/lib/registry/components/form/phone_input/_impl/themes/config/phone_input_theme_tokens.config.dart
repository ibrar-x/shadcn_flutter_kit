/// Global token override entrypoint for the phone_input component.
class PhoneInputThemeTokensConfig {
  const PhoneInputThemeTokensConfig._();

  /// Global component theme override for `PhoneInputTheme`.
  static Object? global;
  static const String globalType = 'PhoneInputTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'padding': null,
    'borderRadius': null,
    'popupConstraints': null,
    'maxWidth': null,
    'flagHeight': null,
    'flagWidth': null,
    'flagGap': null,
    'countryGap': null,
    'flagShape': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
