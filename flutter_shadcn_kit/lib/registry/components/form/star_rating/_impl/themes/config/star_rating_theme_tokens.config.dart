/// Global token override entrypoint for the star_rating component.
class StarRatingThemeTokensConfigGlobalDefaults {
  final Object? activeColor;
  final Object? backgroundColor;
  final Object? starSize;
  final Object? starSpacing;

  const StarRatingThemeTokensConfigGlobalDefaults({
    this.activeColor =
        '_enabled ? theme.colorScheme.primary : theme.colorScheme.mutedForeground',
    this.backgroundColor = 'theme.colorScheme.muted',
    this.starSize = 24.0,
    this.starSpacing = '5.0 * scaling',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'activeColor': activeColor,
    'backgroundColor': backgroundColor,
    'starSize': starSize,
    'starSpacing': starSpacing,
  };
}

class StarRatingThemeTokensConfigGlobalTokens {
  const StarRatingThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class StarRatingThemeTokensConfig {
  const StarRatingThemeTokensConfig._();

  /// Global component theme override for `StarRatingTheme`.
  static Object? global;
  static const String globalType = 'StarRatingTheme';
  static const StarRatingThemeTokensConfigGlobalDefaults globalDefaults =
      StarRatingThemeTokensConfigGlobalDefaults();
  static const StarRatingThemeTokensConfigGlobalTokens globalTokens =
      StarRatingThemeTokensConfigGlobalTokens();
}
