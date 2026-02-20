/// Global token override entrypoint for the code_snippet component.
class CodeSnippetThemeTokensConfig {
  const CodeSnippetThemeTokensConfig._();

  /// Global component theme override for `CodeSnippetTheme`.
  static Object? global;
  static const String globalType = 'CodeSnippetTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'backgroundColor': null,
    'borderColor': null,
    'borderWidth': null,
    'borderRadius': null,
    'padding': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
