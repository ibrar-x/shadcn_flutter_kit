/// Global token override entrypoint for the hover component.
class HoverThemeTokensConfig {
  const HoverThemeTokensConfig._();

  /// Global component theme override for `HoverTheme`.
  static Object? global;
  static const String globalType = 'HoverTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'debounceDuration': 'const Duration(milliseconds: 100)',
    'hitTestBehavior': 'HitTestBehavior.deferToChild',
    'waitDuration': 'const Duration(milliseconds: 500)',
    'minDuration': 'const Duration(milliseconds: 0)',
    'showDuration': 'const Duration(milliseconds: 200)',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
