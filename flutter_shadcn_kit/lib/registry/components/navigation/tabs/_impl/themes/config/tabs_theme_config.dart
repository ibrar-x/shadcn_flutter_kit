// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'tabs_theme_defaults.dart';
import 'tabs_theme_tokens.dart';

class TabsThemeConfig {
  const TabsThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'TabsTheme';
  static const TabsThemeDefaults defaults = TabsThemeDefaults();
  static const TabsThemeTokens tokens = tabsThemeTokens;

  static const Object? tabContainerTheme = null;
  static const String tabContainerThemeType = 'TabContainerTheme';
  static const TabContainerThemeDefaults tabContainerThemeDefaults = TabContainerThemeDefaults();
  static const TabContainerThemeTokens tabContainerThemeTokenConfig = tabContainerThemeTokens;

  static const Object? tabListTheme = null;
  static const String tabListThemeType = 'TabListTheme';
  static const TabListThemeDefaults tabListThemeDefaults = TabListThemeDefaults();
  static const TabListThemeTokens tabListThemeTokenConfig = tabListThemeTokens;

  static const Object? tabPaneTheme = null;
  static const String tabPaneThemeType = 'TabPaneTheme';
  static const TabPaneThemeDefaults tabPaneThemeDefaults = TabPaneThemeDefaults();
  static const TabPaneThemeTokens tabPaneThemeTokenConfig = tabPaneThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    if (T.toString() == tabContainerThemeType) {
      return tabContainerTheme as T?;
    }
    if (T.toString() == tabListThemeType) {
      return tabListTheme as T?;
    }
    if (T.toString() == tabPaneThemeType) {
      return tabPaneTheme as T?;
    }
    return null;
  }
}
