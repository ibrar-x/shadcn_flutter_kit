/// Global token override entrypoint for the navigation_bar component.
class NavigationBarThemeTokensConfig {
  const NavigationBarThemeTokensConfig._();

  /// Global component theme override for `NavigationBarTheme`.
  static Object? global;
  static const String globalType = 'NavigationBarTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'backgroundColor': null,
    'alignment': 'NavigationBarAlignment.center',
    'direction': 'Axis.horizontal',
    'spacing': '8 * scaling',
    'labelType': 'NavigationLabelType.none',
    'labelPosition': 'NavigationLabelPosition.bottom',
    'labelSize': 'NavigationLabelSize.small',
    'padding':
        'EdgeInsets.symmetric( vertical: theme.density.baseGap * scaling, horizontal: theme.density.baseContentPadding * scaling * 0.75, )',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
