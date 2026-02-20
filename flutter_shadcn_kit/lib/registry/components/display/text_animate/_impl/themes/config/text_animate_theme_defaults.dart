// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class TextAnimateThemeConfigGlobalDefaults {
  final Object? style;
  final Object? typewriter;
  final Object? effect;
  final Object? cursor;

  const TextAnimateThemeConfigGlobalDefaults({
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

const textAnimateThemeTokensConfigGlobalDefaults = TextAnimateThemeConfigGlobalDefaults();
