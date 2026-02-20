// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class StarRatingThemeConfigGlobalDefaults {
  final Object? activeColor;
  final Object? backgroundColor;
  final Object? starSize;
  final Object? starSpacing;

  const StarRatingThemeConfigGlobalDefaults({
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

const starRatingThemeTokensConfigGlobalDefaults = StarRatingThemeConfigGlobalDefaults();
