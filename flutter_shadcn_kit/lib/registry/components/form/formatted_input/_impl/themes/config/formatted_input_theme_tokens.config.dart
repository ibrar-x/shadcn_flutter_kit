/// Global token override entrypoint for the formatted_input component.
class FormattedInputThemeTokensConfigGlobalDefaults {
  final Object? height;
  final Object? padding;

  const FormattedInputThemeTokensConfigGlobalDefaults({
    this.height,
    this.padding,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'height': height,
    'padding': padding,
  };
}

class FormattedInputThemeTokensConfigGlobalTokens {
  const FormattedInputThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class FormattedInputThemeTokensConfig {
  const FormattedInputThemeTokensConfig._();

  /// Global component theme override for `FormattedInputTheme`.
  static Object? global;
  static const String globalType = 'FormattedInputTheme';
  static const FormattedInputThemeTokensConfigGlobalDefaults globalDefaults =
      FormattedInputThemeTokensConfigGlobalDefaults();
  static const FormattedInputThemeTokensConfigGlobalTokens globalTokens =
      FormattedInputThemeTokensConfigGlobalTokens();
}
