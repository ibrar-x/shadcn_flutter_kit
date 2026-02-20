// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'menu_theme_defaults.dart';
import 'menu_theme_tokens.dart';

class MenuThemeConfig {
  const MenuThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'MenuTheme';
  static const MenuThemeDefaults defaults = MenuThemeDefaults();
  static const MenuThemeTokens tokens = menuThemeTokens;

  static const Object? menuPopupTheme = null;
  static const String menuPopupThemeType = 'MenuPopupTheme';
  static const MenuPopupThemeDefaults menuPopupThemeDefaults = MenuPopupThemeDefaults();
  static const MenuPopupThemeTokens menuPopupThemeTokenConfig = menuPopupThemeTokens;

  static const Object? menubarTheme = null;
  static const String menubarThemeType = 'MenubarTheme';
  static const MenubarThemeDefaults menubarThemeDefaults = MenubarThemeDefaults();
  static const MenubarThemeTokens menubarThemeTokenConfig = menubarThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    if (T.toString() == menuPopupThemeType) {
      return menuPopupTheme as T?;
    }
    if (T.toString() == menubarThemeType) {
      return menubarTheme as T?;
    }
    return null;
  }
}
