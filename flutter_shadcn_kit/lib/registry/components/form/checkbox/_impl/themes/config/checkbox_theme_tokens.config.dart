/// Global token override entrypoint for the checkbox component.
class CheckboxThemeTokensConfig {
  const CheckboxThemeTokensConfig._();

  /// Global component theme override for `CheckboxTheme`.
  static Object? global;
  static const String globalType = 'CheckboxTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'backgroundColor': null,
    'activeColor': null,
    'borderColor': null,
    'size': null,
    'gap': null,
    'borderRadius': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
