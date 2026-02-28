// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../drawer.dart';
import 'drawer_theme_defaults.dart';
import 'drawer_theme_tokens.dart';

class DrawerThemeConfig {
  const DrawerThemeConfig._();

  static const DrawerTheme? global = null;
  static const String globalType = 'DrawerTheme';
  static const DrawerThemeDefaults defaults = DrawerThemeDefaults();
  static const DrawerThemeTokens tokens = drawerThemeTokens;

  static T? resolve<T extends DrawerTheme>() {
    if (T == DrawerTheme) {
      return global as T?;
    }
    return null;
  }
}
