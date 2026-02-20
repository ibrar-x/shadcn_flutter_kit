// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class NavigationBarThemeConfigGlobalDefaults {
  final Object? backgroundColor;
  final Object? alignment;
  final Object? direction;
  final Object? spacing;
  final Object? labelType;
  final Object? labelPosition;
  final Object? labelSize;
  final Object? padding;

  const NavigationBarThemeConfigGlobalDefaults({
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

const navigationBarThemeTokensConfigGlobalDefaults = NavigationBarThemeConfigGlobalDefaults();
