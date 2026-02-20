/// Global token override entrypoint for the skeleton component.
class SkeletonThemeTokensConfig {
  const SkeletonThemeTokensConfig._();

  /// Global component theme override for `SkeletonTheme`.
  static Object? global;
  static const String globalType = 'SkeletonTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'duration': null,
    'fromColor': null,
    'toColor': null,
    'enableSwitchAnimation': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
