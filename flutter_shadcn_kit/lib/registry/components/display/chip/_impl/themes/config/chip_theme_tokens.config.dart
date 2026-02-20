/// Global token override entrypoint for the chip component.
class ChipThemeTokensConfigGlobalDefaults {
  final Object? padding;
  final Object? style;

  const ChipThemeTokensConfigGlobalDefaults({this.padding, this.style});

  Map<String, Object?> toMap() => <String, Object?>{
    'padding': padding,
    'style': style,
  };
}

class ChipThemeTokensConfigGlobalTokens {
  const ChipThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class ChipThemeTokensConfig {
  const ChipThemeTokensConfig._();

  /// Global component theme override for `ChipTheme`.
  static Object? global;
  static const String globalType = 'ChipTheme';
  static const ChipThemeTokensConfigGlobalDefaults globalDefaults =
      ChipThemeTokensConfigGlobalDefaults();
  static const ChipThemeTokensConfigGlobalTokens globalTokens =
      ChipThemeTokensConfigGlobalTokens();
}
