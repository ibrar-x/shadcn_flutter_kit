/// Global token override entrypoint for the hover_card component.
class HoverCardThemeTokensConfig {
  const HoverCardThemeTokensConfig._();

  /// Global component theme override for `HoverCardTheme`.
  static Object? global;
  static const String globalType = 'HoverCardTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'debounce': null,
    'wait': null,
    'popoverAlignment': null,
    'anchorAlignment': null,
    'popoverOffset': null,
    'behavior': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
