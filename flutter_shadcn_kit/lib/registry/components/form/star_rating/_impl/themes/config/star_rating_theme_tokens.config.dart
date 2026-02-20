/// Global token override entrypoint for the star_rating component.
class StarRatingThemeTokensConfig {
  const StarRatingThemeTokensConfig._();

  /// Global component theme override for `StarRatingTheme`.
  static Object? global;
  static const String globalType = 'StarRatingTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'activeColor': null,
    'backgroundColor': null,
    'starSize': null,
    'starSpacing': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
