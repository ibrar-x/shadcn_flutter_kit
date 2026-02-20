/// Global token override entrypoint for the star_rating component.
class StarRatingThemeTokensConfig {
  const StarRatingThemeTokensConfig._();

  /// Global component theme override for `StarRatingTheme`.
  static Object? global;
  static const String globalType = 'StarRatingTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'activeColor':
        '_enabled ? theme.colorScheme.primary : theme.colorScheme.mutedForeground',
    'backgroundColor': 'theme.colorScheme.muted',
    'starSize': 24.0,
    'starSpacing': '5.0 * scaling',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
