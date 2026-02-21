// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../tabs.dart';
import 'tabs_theme_defaults.dart';
import 'tabs_theme_tokens.dart';

class TabsThemeConfig {
  const TabsThemeConfig._();

  static const TabsTheme? global = null;
  static const String globalType = 'TabsTheme';
  static const TabsThemeDefaults defaults = TabsThemeDefaults();
  static const TabsThemeTokens tokens = tabsThemeTokens;

  static const TabContainerTheme? tabContainerTheme = null;
  static const String tabContainerThemeType = 'TabContainerTheme';
  static const TabContainerThemeDefaults tabContainerThemeDefaults =
      TabContainerThemeDefaults();
  static const TabContainerThemeTokens tabContainerThemeTokenConfig =
      tabContainerThemeTokens;

  static const TabListTheme? tabListTheme = null;
  static const String tabListThemeType = 'TabListTheme';
  static const TabListThemeDefaults tabListThemeDefaults =
      TabListThemeDefaults();
  static const TabListThemeTokens tabListThemeTokenConfig = tabListThemeTokens;

  static const TabPaneTheme? tabPaneTheme = null;
  static const String tabPaneThemeType = 'TabPaneTheme';
  static const TabPaneThemeDefaults tabPaneThemeDefaults =
      TabPaneThemeDefaults();
  static const TabPaneThemeTokens tabPaneThemeTokenConfig = tabPaneThemeTokens;

  static T? resolve<T>() {
    if (T == TabsTheme) {
      return global as T?;
    }
    if (T == TabContainerTheme) {
      return tabContainerTheme as T?;
    }
    if (T == TabListTheme) {
      return tabListTheme as T?;
    }
    if (T == TabPaneTheme) {
      return tabPaneTheme as T?;
    }
    return null;
  }
}
