/// Global token override entrypoint for the radio_group component.
class RadioGroupThemeTokensConfig {
  const RadioGroupThemeTokensConfig._();

  /// Global component theme override.
  static Object? global;
  static const String globalType = 'RadioCardTheme';
  static const Map<String, Object?> globalTokens = <String, Object?>{};

  /// Global component theme override for `RadioTheme`.
  static Object? radioTheme;
  static const String radioThemeType = 'RadioTheme';
  static const Map<String, Object?> radioThemeTokens = <String, Object?>{};
}
