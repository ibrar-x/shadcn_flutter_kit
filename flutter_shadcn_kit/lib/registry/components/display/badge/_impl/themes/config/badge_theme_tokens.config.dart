/// Global token override entrypoint for the badge component.
class BadgeThemeTokensConfigGlobalDefaults {
  final Object? primaryStyle;
  final Object? secondaryStyle;
  final Object? outlineStyle;
  final Object? destructiveStyle;

  const BadgeThemeTokensConfigGlobalDefaults({
    this.primaryStyle,
    this.secondaryStyle,
    this.outlineStyle,
    this.destructiveStyle,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'primaryStyle': primaryStyle,
    'secondaryStyle': secondaryStyle,
    'outlineStyle': outlineStyle,
    'destructiveStyle': destructiveStyle,
  };
}

class BadgeThemeTokensConfigGlobalTokens {
  const BadgeThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class BadgeThemeTokensConfig {
  const BadgeThemeTokensConfig._();

  /// Global component theme override for `BadgeTheme`.
  static Object? global;
  static const String globalType = 'BadgeTheme';
  static const BadgeThemeTokensConfigGlobalDefaults globalDefaults =
      BadgeThemeTokensConfigGlobalDefaults();
  static const BadgeThemeTokensConfigGlobalTokens globalTokens =
      BadgeThemeTokensConfigGlobalTokens();
}
