/// Global token override entrypoint for the tabs component.
class TabsThemeTokensConfig {
  const TabsThemeTokensConfig._();

  /// Global component theme override for `TabsTheme`.
  static Object? global;
  static const String globalType = 'TabsTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'containerPadding': null,
    'tabPadding': null,
    'backgroundColor': 'theme.colorScheme.card',
    'borderRadius': 'theme.borderRadiusLg',
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};

  /// Global component theme override for `TabContainerTheme`.
  static Object? tabContainerTheme;
  static const String tabContainerThemeType = 'TabContainerTheme';
  static const Map<String, Object?> tabContainerThemeDefaults =
      <String, Object?>{'builder': null, 'childBuilder': null};
  static const Map<String, Object?> tabContainerThemeTokens =
      <String, Object?>{};

  /// Global component theme override for `TabListTheme`.
  static Object? tabListTheme;
  static const String tabListThemeType = 'TabListTheme';
  static const Map<String, Object?> tabListThemeDefaults = <String, Object?>{
    'borderColor': null,
    'borderWidth': null,
    'indicatorColor': null,
    'indicatorHeight': null,
  };
  static const Map<String, Object?> tabListThemeTokens = <String, Object?>{};

  /// Global component theme override for `TabPaneTheme`.
  static Object? tabPaneTheme;
  static const String tabPaneThemeType = 'TabPaneTheme';
  static const Map<String, Object?> tabPaneThemeDefaults = <String, Object?>{
    'borderRadius': 'theme.borderRadiusLg',
    'backgroundColor': 'theme.colorScheme.card',
    'border': null,
    'barHeight': '(32 * theme.scaling)',
  };
  static const Map<String, Object?> tabPaneThemeTokens = <String, Object?>{};
}
