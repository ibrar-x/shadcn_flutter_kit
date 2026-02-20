/// Global token override entrypoint for the stage_container component.
class StageContainerThemeTokensConfig {
  const StageContainerThemeTokensConfig._();

  /// Global component theme override for `StageContainerTheme`.
  static Object? global;
  static const String globalType = 'StageContainerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'breakpoint': null,
    'padding': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
