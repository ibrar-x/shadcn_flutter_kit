/// Global token override entrypoint for the tabs component.
class TabsThemeTokensConfigGlobalDefaults {
  final Object? containerPadding;
  final Object? tabPadding;
  final Object? backgroundColor;
  final Object? borderRadius;

  const TabsThemeTokensConfigGlobalDefaults({
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

class TabsThemeTokensConfigGlobalTokens {
  const TabsThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TabsThemeTokensConfigTabContainerThemeDefaults {
  final Object? builder;
  final Object? childBuilder;

  const TabsThemeTokensConfigTabContainerThemeDefaults({
    this.builder,
    this.childBuilder,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'builder': builder,
    'childBuilder': childBuilder,
  };
}

class TabsThemeTokensConfigTabContainerThemeTokens {
  const TabsThemeTokensConfigTabContainerThemeTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TabsThemeTokensConfigTabListThemeDefaults {
  final Object? borderColor;
  final Object? borderWidth;
  final Object? indicatorColor;
  final Object? indicatorHeight;

  const TabsThemeTokensConfigTabListThemeDefaults({
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

class TabsThemeTokensConfigTabListThemeTokens {
  const TabsThemeTokensConfigTabListThemeTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TabsThemeTokensConfigTabPaneThemeDefaults {
  final Object? borderRadius;
  final Object? backgroundColor;
  final Object? border;
  final Object? barHeight;

  const TabsThemeTokensConfigTabPaneThemeDefaults({
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

class TabsThemeTokensConfigTabPaneThemeTokens {
  const TabsThemeTokensConfigTabPaneThemeTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class TabsThemeTokensConfig {
  const TabsThemeTokensConfig._();

  /// Global component theme override for `TabsTheme`.
  static Object? global;
  static const String globalType = 'TabsTheme';
  static const TabsThemeTokensConfigGlobalDefaults globalDefaults =
      TabsThemeTokensConfigGlobalDefaults();
  static const TabsThemeTokensConfigGlobalTokens globalTokens =
      TabsThemeTokensConfigGlobalTokens();

  /// Global component theme override for `TabContainerTheme`.
  static Object? tabContainerTheme;
  static const String tabContainerThemeType = 'TabContainerTheme';
  static const TabsThemeTokensConfigTabContainerThemeDefaults
  tabContainerThemeDefaults = TabsThemeTokensConfigTabContainerThemeDefaults();
  static const TabsThemeTokensConfigTabContainerThemeTokens
  tabContainerThemeTokens = TabsThemeTokensConfigTabContainerThemeTokens();

  /// Global component theme override for `TabListTheme`.
  static Object? tabListTheme;
  static const String tabListThemeType = 'TabListTheme';
  static const TabsThemeTokensConfigTabListThemeDefaults tabListThemeDefaults =
      TabsThemeTokensConfigTabListThemeDefaults();
  static const TabsThemeTokensConfigTabListThemeTokens tabListThemeTokens =
      TabsThemeTokensConfigTabListThemeTokens();

  /// Global component theme override for `TabPaneTheme`.
  static Object? tabPaneTheme;
  static const String tabPaneThemeType = 'TabPaneTheme';
  static const TabsThemeTokensConfigTabPaneThemeDefaults tabPaneThemeDefaults =
      TabsThemeTokensConfigTabPaneThemeDefaults();
  static const TabsThemeTokensConfigTabPaneThemeTokens tabPaneThemeTokens =
      TabsThemeTokensConfigTabPaneThemeTokens();
}
