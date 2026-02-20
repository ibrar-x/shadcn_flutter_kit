/// Global token override entrypoint for the refresh_trigger component.
class RefreshTriggerThemeTokensConfigGlobalDefaults {
  final Object? minExtent;
  final Object? maxExtent;
  final Object? indicatorBuilder;
  final Object? curve;
  final Object? completeDuration;

  const RefreshTriggerThemeTokensConfigGlobalDefaults({
    this.minExtent = '75.0 * theme.scaling',
    this.maxExtent = '150.0 * theme.scaling',
    this.indicatorBuilder = 'RefreshTrigger.defaultIndicatorBuilder',
    this.curve = 'Curves.easeOutSine',
    this.completeDuration = 'const Duration(milliseconds: 500)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'minExtent': minExtent,
    'maxExtent': maxExtent,
    'indicatorBuilder': indicatorBuilder,
    'curve': curve,
    'completeDuration': completeDuration,
  };
}

class RefreshTriggerThemeTokensConfigGlobalTokens {
  const RefreshTriggerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class RefreshTriggerThemeTokensConfig {
  const RefreshTriggerThemeTokensConfig._();

  /// Global component theme override for `RefreshTriggerTheme`.
  static Object? global;
  static const String globalType = 'RefreshTriggerTheme';
  static const RefreshTriggerThemeTokensConfigGlobalDefaults globalDefaults =
      RefreshTriggerThemeTokensConfigGlobalDefaults();
  static const RefreshTriggerThemeTokensConfigGlobalTokens globalTokens =
      RefreshTriggerThemeTokensConfigGlobalTokens();
}
