// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'menubar_theme_defaults.dart';
import 'menubar_theme_tokens.dart';

class MenubarThemeConfig {
  const MenubarThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'MenubarTheme';
  static const MenubarThemeDefaults defaults = MenubarThemeDefaults();
  static const MenubarThemeTokens tokens = menubarThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
