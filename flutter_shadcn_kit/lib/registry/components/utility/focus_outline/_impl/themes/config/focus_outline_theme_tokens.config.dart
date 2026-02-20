/// Global token override entrypoint for the focus_outline component.
class FocusOutlineThemeTokensConfigGlobalDefaults {
  final Object? align;
  final Object? borderRadius;
  final Object? border;

  const FocusOutlineThemeTokensConfigGlobalDefaults({
    this.align,
    this.borderRadius,
    this.border,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'align': align,
    'borderRadius': borderRadius,
    'border': border,
  };
}

class FocusOutlineThemeTokensConfigGlobalTokens {
  const FocusOutlineThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class FocusOutlineThemeTokensConfig {
  const FocusOutlineThemeTokensConfig._();

  /// Global component theme override for `FocusOutlineTheme`.
  static Object? global;
  static const String globalType = 'FocusOutlineTheme';
  static const FocusOutlineThemeTokensConfigGlobalDefaults globalDefaults =
      FocusOutlineThemeTokensConfigGlobalDefaults();
  static const FocusOutlineThemeTokensConfigGlobalTokens globalTokens =
      FocusOutlineThemeTokensConfigGlobalTokens();
}
