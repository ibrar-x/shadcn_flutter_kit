/// Global token override entrypoint for the hover component.
class HoverThemeTokensConfig {
  const HoverThemeTokensConfig._();

  /// Global component theme override for `HoverTheme`.
  static Object? global;
  static const String globalType = 'HoverTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'debounceDuration': null,
    'hitTestBehavior': null,
    'waitDuration': null,
    'minDuration': null,
    'showDuration': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
