/// Global token override entrypoint for the hover_card component.
class HoverCardThemeTokensConfig {
  const HoverCardThemeTokensConfig._();

  /// Global component theme override for `HoverCardTheme`.
  static Object? global;
  static const String globalType = 'HoverCardTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'debounce': 'const Duration(milliseconds: 500)',
    'wait': 'const Duration(milliseconds: 500)',
    'popoverAlignment': 'Alignment.topCenter',
    'anchorAlignment': 'Alignment.bottomCenter',
    'popoverOffset': 'const Offset(0, 8)',
    'behavior': 'HitTestBehavior.deferToChild',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
