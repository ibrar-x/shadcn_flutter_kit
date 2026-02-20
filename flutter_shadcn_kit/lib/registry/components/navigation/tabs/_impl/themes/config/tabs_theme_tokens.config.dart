/// Global token override entrypoint for the tabs component.
class TabsThemeTokensConfig {
  const TabsThemeTokensConfig._();

  /// Global component theme override.
  static Object? global;
  static const String globalType = 'TabsTheme';

  /// Global component theme override for `TabContainerTheme`.
  static Object? tabContainerTheme;
  static const String tabContainerThemeType = 'TabContainerTheme';

  /// Global component theme override for `TabListTheme`.
  static Object? tabListTheme;
  static const String tabListThemeType = 'TabListTheme';

  /// Global component theme override for `TabPaneTheme`.
  static Object? tabPaneTheme;
  static const String tabPaneThemeType = 'TabPaneTheme';
}
