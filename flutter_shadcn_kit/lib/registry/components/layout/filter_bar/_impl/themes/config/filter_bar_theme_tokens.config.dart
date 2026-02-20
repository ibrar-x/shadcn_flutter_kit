/// Global token override entrypoint for the filter_bar component.
class FilterBarThemeTokensConfigGlobalDefaults {
  const FilterBarThemeTokensConfigGlobalDefaults();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class FilterBarThemeTokensConfigGlobalTokens {
  const FilterBarThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class FilterBarThemeTokensConfig {
  const FilterBarThemeTokensConfig._();

  /// Default token payload for this component config.
  static const FilterBarThemeTokensConfigGlobalDefaults globalDefaults =
      FilterBarThemeTokensConfigGlobalDefaults();

  /// Override token payload for this component config.
  static const FilterBarThemeTokensConfigGlobalTokens globalTokens =
      FilterBarThemeTokensConfigGlobalTokens();
}
