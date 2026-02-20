/// Global token override entrypoint for the text_animate component.
class TextAnimateThemeTokensConfig {
  const TextAnimateThemeTokensConfig._();

  /// Global component theme override for `TextAnimateTheme`.
  static Object? global;
  static const String globalType = 'TextAnimateTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'style': 'const TextStyle()',
    'typewriter': 'const TypewriterEffect()',
    'effect': 'const NoEffect()',
    'cursor': 'const StreamingCursor.none()',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
