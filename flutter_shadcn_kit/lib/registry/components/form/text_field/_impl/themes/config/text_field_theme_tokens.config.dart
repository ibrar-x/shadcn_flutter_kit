/// Global token override entrypoint for the text_field component.
class TextFieldThemeTokensConfig {
  const TextFieldThemeTokensConfig._();

  /// Global component theme override for `TextFieldTheme`.
  static Object? global;
  static const String globalType = 'TextFieldTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'border': null,
    'borderRadius': null,
    'filled': null,
    'padding': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
