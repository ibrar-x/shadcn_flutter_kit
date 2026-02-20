/// Global token override entrypoint for the multiple_choice component.
class MultipleChoiceThemeTokensConfigGlobalDefaults {
  final Object? allowUnselect;

  const MultipleChoiceThemeTokensConfigGlobalDefaults({
    this.allowUnselect = true,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'allowUnselect': allowUnselect,
  };
}

class MultipleChoiceThemeTokensConfigGlobalTokens {
  const MultipleChoiceThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class MultipleChoiceThemeTokensConfig {
  const MultipleChoiceThemeTokensConfig._();

  /// Global component theme override for `MultipleChoiceTheme`.
  static Object? global;
  static const String globalType = 'MultipleChoiceTheme';
  static const MultipleChoiceThemeTokensConfigGlobalDefaults globalDefaults =
      MultipleChoiceThemeTokensConfigGlobalDefaults();
  static const MultipleChoiceThemeTokensConfigGlobalTokens globalTokens =
      MultipleChoiceThemeTokensConfigGlobalTokens();
}
