/// Global token override entrypoint for the hover component.
class HoverThemeTokensConfigGlobalDefaults {
  final Object? debounceDuration;
  final Object? hitTestBehavior;
  final Object? waitDuration;
  final Object? minDuration;
  final Object? showDuration;

  const HoverThemeTokensConfigGlobalDefaults({
    this.debounceDuration = 'const Duration(milliseconds: 100)',
    this.hitTestBehavior = 'HitTestBehavior.deferToChild',
    this.waitDuration = 'const Duration(milliseconds: 500)',
    this.minDuration = 'const Duration(milliseconds: 0)',
    this.showDuration = 'const Duration(milliseconds: 200)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'debounceDuration': debounceDuration,
    'hitTestBehavior': hitTestBehavior,
    'waitDuration': waitDuration,
    'minDuration': minDuration,
    'showDuration': showDuration,
  };
}

class HoverThemeTokensConfigGlobalTokens {
  const HoverThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class HoverThemeTokensConfig {
  const HoverThemeTokensConfig._();

  /// Global component theme override for `HoverTheme`.
  static Object? global;
  static const String globalType = 'HoverTheme';
  static const HoverThemeTokensConfigGlobalDefaults globalDefaults =
      HoverThemeTokensConfigGlobalDefaults();
  static const HoverThemeTokensConfigGlobalTokens globalTokens =
      HoverThemeTokensConfigGlobalTokens();
}
