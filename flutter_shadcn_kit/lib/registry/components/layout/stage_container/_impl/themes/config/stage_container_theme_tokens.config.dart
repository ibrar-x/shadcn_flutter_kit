/// Global token override entrypoint for the stage_container component.
class StageContainerThemeTokensConfigGlobalDefaults {
  final Object? breakpoint;
  final Object? padding;

  const StageContainerThemeTokensConfigGlobalDefaults({
    this.breakpoint,
    this.padding,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'breakpoint': breakpoint,
    'padding': padding,
  };
}

class StageContainerThemeTokensConfigGlobalTokens {
  const StageContainerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class StageContainerThemeTokensConfig {
  const StageContainerThemeTokensConfig._();

  /// Global component theme override for `StageContainerTheme`.
  static Object? global;
  static const String globalType = 'StageContainerTheme';
  static const StageContainerThemeTokensConfigGlobalDefaults globalDefaults =
      StageContainerThemeTokensConfigGlobalDefaults();
  static const StageContainerThemeTokensConfigGlobalTokens globalTokens =
      StageContainerThemeTokensConfigGlobalTokens();
}
