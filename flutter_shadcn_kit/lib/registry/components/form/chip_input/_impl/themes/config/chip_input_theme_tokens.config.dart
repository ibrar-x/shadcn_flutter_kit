/// Global token override entrypoint for the chip_input component.
class ChipInputThemeTokensConfig {
  const ChipInputThemeTokensConfig._();

  /// Global component theme override for `ChipInputTheme`.
  static Object? global;
  static const String globalType = 'ChipInputTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'spacing': null,
    'useChips': true,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
