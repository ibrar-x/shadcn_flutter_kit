/// Global token override entrypoint for the refresh_trigger component.
class RefreshTriggerThemeTokensConfig {
  const RefreshTriggerThemeTokensConfig._();

  /// Global component theme override for `RefreshTriggerTheme`.
  static Object? global;
  static const String globalType = 'RefreshTriggerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'minExtent': null,
    'maxExtent': null,
    'indicatorBuilder': null,
    'curve': null,
    'completeDuration': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
