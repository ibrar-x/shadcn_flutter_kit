// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'drawer_theme_defaults.dart';
import 'drawer_theme_tokens.dart';

class DrawerThemeConfig {
  const DrawerThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'DrawerTheme';
  static const DrawerThemeDefaults defaults = DrawerThemeDefaults();
  static const DrawerThemeTokens tokens = drawerThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
