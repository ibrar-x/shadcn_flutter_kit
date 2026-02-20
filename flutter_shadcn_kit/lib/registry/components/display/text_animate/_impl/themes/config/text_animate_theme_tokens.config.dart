/// Global token override entrypoint for the text_animate component.
class TextAnimateThemeTokensConfigGlobalDefaults {
  final Object? style;
  final Object? typewriter;
  final Object? effect;
  final Object? cursor;

  const TextAnimateThemeTokensConfigGlobalDefaults({
    this.style = 'const TextStyle()',
    this.typewriter = 'const TypewriterEffect()',
    this.effect = 'const NoEffect()',
    this.cursor = 'const StreamingCursor.none()',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'style': style,
    'typewriter': typewriter,
    'effect': effect,
    'cursor': cursor,
  };
}

class TextAnimateThemeTokensConfigGlobalTokens {
  const TextAnimateThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TextAnimateThemeTokensConfig {
  const TextAnimateThemeTokensConfig._();

  /// Global component theme override for `TextAnimateTheme`.
  static Object? global;
  static const String globalType = 'TextAnimateTheme';
  static const TextAnimateThemeTokensConfigGlobalDefaults globalDefaults =
      TextAnimateThemeTokensConfigGlobalDefaults();
  static const TextAnimateThemeTokensConfigGlobalTokens globalTokens =
      TextAnimateThemeTokensConfigGlobalTokens();
}
