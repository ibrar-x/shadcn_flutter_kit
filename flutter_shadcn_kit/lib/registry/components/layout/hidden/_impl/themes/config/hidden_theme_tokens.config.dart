/// Global token override entrypoint for the hidden component.
class HiddenThemeTokensConfigGlobalDefaults {
  final Object? direction;
  final Object? duration;
  final Object? curve;
  final Object? reverse;
  final Object? keepCrossAxisSize;
  final Object? keepMainAxisSize;

  const HiddenThemeTokensConfigGlobalDefaults({
    this.direction,
    this.duration,
    this.curve,
    this.reverse,
    this.keepCrossAxisSize,
    this.keepMainAxisSize,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'direction': direction,
    'duration': duration,
    'curve': curve,
    'reverse': reverse,
    'keepCrossAxisSize': keepCrossAxisSize,
    'keepMainAxisSize': keepMainAxisSize,
  };
}

class HiddenThemeTokensConfigGlobalTokens {
  const HiddenThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class HiddenThemeTokensConfig {
  const HiddenThemeTokensConfig._();

  /// Global component theme override for `HiddenTheme`.
  static Object? global;
  static const String globalType = 'HiddenTheme';
  static const HiddenThemeTokensConfigGlobalDefaults globalDefaults =
      HiddenThemeTokensConfigGlobalDefaults();
  static const HiddenThemeTokensConfigGlobalTokens globalTokens =
      HiddenThemeTokensConfigGlobalTokens();
}
