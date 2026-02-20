/// Global token override entrypoint for the navigation_bar component.
class NavigationBarThemeTokensConfigGlobalDefaults {
  final Object? backgroundColor;
  final Object? alignment;
  final Object? direction;
  final Object? spacing;
  final Object? labelType;
  final Object? labelPosition;
  final Object? labelSize;
  final Object? padding;

  const NavigationBarThemeTokensConfigGlobalDefaults({
    this.backgroundColor,
    this.alignment = 'NavigationBarAlignment.center',
    this.direction = 'Axis.horizontal',
    this.spacing = '8 * scaling',
    this.labelType = 'NavigationLabelType.none',
    this.labelPosition = 'NavigationLabelPosition.bottom',
    this.labelSize = 'NavigationLabelSize.small',
    this.padding =
        'EdgeInsets.symmetric( vertical: theme.density.baseGap * scaling, horizontal: theme.density.baseContentPadding * scaling * 0.75, )',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'backgroundColor': backgroundColor,
    'alignment': alignment,
    'direction': direction,
    'spacing': spacing,
    'labelType': labelType,
    'labelPosition': labelPosition,
    'labelSize': labelSize,
    'padding': padding,
  };
}

class NavigationBarThemeTokensConfigGlobalTokens {
  const NavigationBarThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class NavigationBarThemeTokensConfig {
  const NavigationBarThemeTokensConfig._();

  /// Global component theme override for `NavigationBarTheme`.
  static Object? global;
  static const String globalType = 'NavigationBarTheme';
  static const NavigationBarThemeTokensConfigGlobalDefaults globalDefaults =
      NavigationBarThemeTokensConfigGlobalDefaults();
  static const NavigationBarThemeTokensConfigGlobalTokens globalTokens =
      NavigationBarThemeTokensConfigGlobalTokens();
}
