/// Global token override entrypoint for the tracker component.
class TrackerThemeTokensConfig {
  const TrackerThemeTokensConfig._();

  /// Global component theme override for `TrackerTheme`.
  static Object? global;
  static const String globalType = 'TrackerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'radius': null,
    'gap': null,
    'itemHeight': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
