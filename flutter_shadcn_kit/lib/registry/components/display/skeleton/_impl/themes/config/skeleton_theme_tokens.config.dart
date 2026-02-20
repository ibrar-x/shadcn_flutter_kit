/// Global token override entrypoint for the skeleton component.
class SkeletonThemeTokensConfigGlobalDefaults {
  final Object? duration;
  final Object? fromColor;
  final Object? toColor;
  final Object? enableSwitchAnimation;

  const SkeletonThemeTokensConfigGlobalDefaults({
    this.duration,
    this.fromColor,
    this.toColor,
    this.enableSwitchAnimation,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'duration': duration,
    'fromColor': fromColor,
    'toColor': toColor,
    'enableSwitchAnimation': enableSwitchAnimation,
  };
}

class SkeletonThemeTokensConfigGlobalTokens {
  const SkeletonThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class SkeletonThemeTokensConfig {
  const SkeletonThemeTokensConfig._();

  /// Global component theme override for `SkeletonTheme`.
  static Object? global;
  static const String globalType = 'SkeletonTheme';
  static const SkeletonThemeTokensConfigGlobalDefaults globalDefaults =
      SkeletonThemeTokensConfigGlobalDefaults();
  static const SkeletonThemeTokensConfigGlobalTokens globalTokens =
      SkeletonThemeTokensConfigGlobalTokens();
}
