/// Global token override entrypoint for the chip component.
class ChipThemeTokensConfig {
  const ChipThemeTokensConfig._();

  /// Global component theme override for `ChipTheme`.
  static Object? global;
  static const String globalType = 'ChipTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'padding': null,
    'style': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
