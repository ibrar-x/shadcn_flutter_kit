/// Global token override entrypoint for the hover_card component.
class HoverCardThemeTokensConfigGlobalDefaults {
  final Object? debounce;
  final Object? wait;
  final Object? popoverAlignment;
  final Object? anchorAlignment;
  final Object? popoverOffset;
  final Object? behavior;

  const HoverCardThemeTokensConfigGlobalDefaults({
    this.debounce = 'const Duration(milliseconds: 500)',
    this.wait = 'const Duration(milliseconds: 500)',
    this.popoverAlignment = 'Alignment.topCenter',
    this.anchorAlignment = 'Alignment.bottomCenter',
    this.popoverOffset = 'const Offset(0, 8)',
    this.behavior = 'HitTestBehavior.deferToChild',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'debounce': debounce,
    'wait': wait,
    'popoverAlignment': popoverAlignment,
    'anchorAlignment': anchorAlignment,
    'popoverOffset': popoverOffset,
    'behavior': behavior,
  };
}

class HoverCardThemeTokensConfigGlobalTokens {
  const HoverCardThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class HoverCardThemeTokensConfig {
  const HoverCardThemeTokensConfig._();

  /// Global component theme override for `HoverCardTheme`.
  static Object? global;
  static const String globalType = 'HoverCardTheme';
  static const HoverCardThemeTokensConfigGlobalDefaults globalDefaults =
      HoverCardThemeTokensConfigGlobalDefaults();
  static const HoverCardThemeTokensConfigGlobalTokens globalTokens =
      HoverCardThemeTokensConfigGlobalTokens();
}
