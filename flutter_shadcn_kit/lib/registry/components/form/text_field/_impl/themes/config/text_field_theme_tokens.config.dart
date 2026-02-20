/// Global token override entrypoint for the text_field component.
class TextFieldThemeTokensConfigGlobalDefaults {
  final Object? border;
  final Object? borderRadius;
  final Object? filled;
  final Object? padding;

  const TextFieldThemeTokensConfigGlobalDefaults({
    this.border =
        'Border.all( color: theme.colorScheme.border, strokeAlign: BorderSide.strokeAlignCenter, )',
    this.borderRadius,
    this.filled = false,
    this.padding =
        'EdgeInsets.symmetric(horizontal: densityContentPadding * 0.75)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'border': border,
    'borderRadius': borderRadius,
    'filled': filled,
    'padding': padding,
  };
}

class TextFieldThemeTokensConfigGlobalTokens {
  const TextFieldThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TextFieldThemeTokensConfig {
  const TextFieldThemeTokensConfig._();

  /// Global component theme override for `TextFieldTheme`.
  static Object? global;
  static const String globalType = 'TextFieldTheme';
  static const TextFieldThemeTokensConfigGlobalDefaults globalDefaults =
      TextFieldThemeTokensConfigGlobalDefaults();
  static const TextFieldThemeTokensConfigGlobalTokens globalTokens =
      TextFieldThemeTokensConfigGlobalTokens();
}
