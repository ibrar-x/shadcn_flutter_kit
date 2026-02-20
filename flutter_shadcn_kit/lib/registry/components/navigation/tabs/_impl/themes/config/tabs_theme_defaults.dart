// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class TabsThemeConfigGlobalDefaults {
  final Object? containerPadding;
  final Object? tabPadding;
  final Object? backgroundColor;
  final Object? borderRadius;

  const TabsThemeConfigGlobalDefaults({
    this.containerPadding,
    this.tabPadding,
    this.backgroundColor = 'theme.colorScheme.card',
    this.borderRadius = 'theme.borderRadiusLg',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'containerPadding': containerPadding,
    'tabPadding': tabPadding,
    'backgroundColor': backgroundColor,
    'borderRadius': borderRadius,
  };
}

class TabsThemeConfigTabContainerThemeDefaults {
  final Object? builder;
  final Object? childBuilder;

  const TabsThemeConfigTabContainerThemeDefaults({
    this.builder,
    this.childBuilder,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'builder': builder,
    'childBuilder': childBuilder,
  };
}

class TabsThemeConfigTabListThemeDefaults {
  final Object? borderColor;
  final Object? borderWidth;
  final Object? indicatorColor;
  final Object? indicatorHeight;

  const TabsThemeConfigTabListThemeDefaults({
    this.borderColor,
    this.borderWidth,
    this.indicatorColor,
    this.indicatorHeight,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'borderColor': borderColor,
    'borderWidth': borderWidth,
    'indicatorColor': indicatorColor,
    'indicatorHeight': indicatorHeight,
  };
}

class TabsThemeConfigTabPaneThemeDefaults {
  final Object? borderRadius;
  final Object? backgroundColor;
  final Object? border;
  final Object? barHeight;

  const TabsThemeConfigTabPaneThemeDefaults({
    this.borderRadius = 'theme.borderRadiusLg',
    this.backgroundColor = 'theme.colorScheme.card',
    this.border,
    this.barHeight = '(32 * theme.scaling)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'borderRadius': borderRadius,
    'backgroundColor': backgroundColor,
    'border': border,
    'barHeight': barHeight,
  };
}

const tabsThemeTokensConfigGlobalDefaults = TabsThemeConfigGlobalDefaults();
const tabsThemeTokensConfigTabContainerThemeDefaults = TabsThemeConfigTabContainerThemeDefaults();
const tabsThemeTokensConfigTabListThemeDefaults = TabsThemeConfigTabListThemeDefaults();
const tabsThemeTokensConfigTabPaneThemeDefaults = TabsThemeConfigTabPaneThemeDefaults();
