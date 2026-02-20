/// Global token override entrypoint for the hidden component.
class HiddenThemeTokensConfig {
  const HiddenThemeTokensConfig._();

  /// Global component theme override for `HiddenTheme`.
  static Object? global;
  static const String globalType = 'HiddenTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'direction': null,
    'duration': null,
    'curve': null,
    'reverse': null,
    'keepCrossAxisSize': null,
    'keepMainAxisSize': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
