/// Global token override entrypoint for the code_snippet component.
class CodeSnippetThemeTokensConfigGlobalDefaults {
  final Object? backgroundColor;
  final Object? borderColor;
  final Object? borderWidth;
  final Object? borderRadius;
  final Object? padding;

  const CodeSnippetThemeTokensConfigGlobalDefaults({
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'backgroundColor': backgroundColor,
    'borderColor': borderColor,
    'borderWidth': borderWidth,
    'borderRadius': borderRadius,
    'padding': padding,
  };
}

class CodeSnippetThemeTokensConfigGlobalTokens {
  const CodeSnippetThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class CodeSnippetThemeTokensConfig {
  const CodeSnippetThemeTokensConfig._();

  /// Global component theme override for `CodeSnippetTheme`.
  static Object? global;
  static const String globalType = 'CodeSnippetTheme';
  static const CodeSnippetThemeTokensConfigGlobalDefaults globalDefaults =
      CodeSnippetThemeTokensConfigGlobalDefaults();
  static const CodeSnippetThemeTokensConfigGlobalTokens globalTokens =
      CodeSnippetThemeTokensConfigGlobalTokens();
}
