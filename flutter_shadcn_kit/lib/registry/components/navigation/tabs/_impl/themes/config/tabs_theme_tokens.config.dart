/// Global token override entrypoint for the tabs component.
class TabsThemeTokensConfig {
  const TabsThemeTokensConfig._();

  /// Global component theme override.
  static Object? global;
  static const String globalType = 'TabsTheme';
  static const Map<String, Object?> globalTokens = <String, Object?>{};

  /// Global component theme override for `TabContainerTheme`.
  static Object? tabContainerTheme;
  static const String tabContainerThemeType = 'TabContainerTheme';
  static const Map<String, Object?> tabContainerThemeTokens = <String, Object?>{};

  /// Global component theme override for `TabListTheme`.
  static Object? tabListTheme;
  static const String tabListThemeType = 'TabListTheme';
  static const Map<String, Object?> tabListThemeTokens = <String, Object?>{};

  /// Global component theme override for `TabPaneTheme`.
  static Object? tabPaneTheme;
  static const String tabPaneThemeType = 'TabPaneTheme';
  static const Map<String, Object?> tabPaneThemeTokens = <String, Object?>{};
}
