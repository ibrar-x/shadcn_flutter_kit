/// Global token override entrypoint for the chip_input component.
class ChipInputThemeTokensConfigGlobalDefaults {
  final Object? spacing;
  final Object? useChips;

  const ChipInputThemeTokensConfigGlobalDefaults({
    this.spacing,
    this.useChips = true,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'spacing': spacing,
    'useChips': useChips,
  };
}

class ChipInputThemeTokensConfigGlobalTokens {
  const ChipInputThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class ChipInputThemeTokensConfig {
  const ChipInputThemeTokensConfig._();

  /// Global component theme override for `ChipInputTheme`.
  static Object? global;
  static const String globalType = 'ChipInputTheme';
  static const ChipInputThemeTokensConfigGlobalDefaults globalDefaults =
      ChipInputThemeTokensConfigGlobalDefaults();
  static const ChipInputThemeTokensConfigGlobalTokens globalTokens =
      ChipInputThemeTokensConfigGlobalTokens();
}
