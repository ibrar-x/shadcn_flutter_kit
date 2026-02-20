/// Global token override entrypoint for the progress component.
class ProgressThemeTokensConfig {
  const ProgressThemeTokensConfig._();

  /// Global component theme override for `ProgressTheme`.
  static Object? global;
  static const String globalType = 'ProgressTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'color': null,
    'backgroundColor': null,
    'borderRadius': null,
    'minHeight': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
