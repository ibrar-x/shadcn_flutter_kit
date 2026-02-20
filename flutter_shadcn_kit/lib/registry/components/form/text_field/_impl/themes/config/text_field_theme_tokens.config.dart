/// Global token override entrypoint for the text_field component.
class TextFieldThemeTokensConfig {
  const TextFieldThemeTokensConfig._();

  /// Global component theme override for `TextFieldTheme`.
  static Object? global;
  static const String globalType = 'TextFieldTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'border':
        'Border.all( color: theme.colorScheme.border, strokeAlign: BorderSide.strokeAlignCenter, )',
    'borderRadius': null,
    'filled': false,
    'padding': 'EdgeInsets.symmetric(horizontal: densityContentPadding * 0.75)',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
