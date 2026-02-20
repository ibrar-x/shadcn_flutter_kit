/// Global token override entrypoint for the badge component.
class BadgeThemeTokensConfig {
  const BadgeThemeTokensConfig._();

  /// Global component theme override for `BadgeTheme`.
  static Object? global;
  static const String globalType = 'BadgeTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'primaryStyle': null,
    'secondaryStyle': null,
    'outlineStyle': null,
    'destructiveStyle': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
