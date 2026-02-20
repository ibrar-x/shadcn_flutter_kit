/// Global token override entrypoint for the multiple_choice component.
class MultipleChoiceThemeTokensConfig {
  const MultipleChoiceThemeTokensConfig._();

  /// Global component theme override for `MultipleChoiceTheme`.
  static Object? global;
  static const String globalType = 'MultipleChoiceTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'allowUnselect': true,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
