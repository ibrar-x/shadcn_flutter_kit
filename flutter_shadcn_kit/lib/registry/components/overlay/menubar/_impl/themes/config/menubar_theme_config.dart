// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../menubar.dart';
import 'menubar_theme_defaults.dart';
import 'menubar_theme_tokens.dart';

class MenubarThemeConfig {
  const MenubarThemeConfig._();

  static const MenubarTheme? global = null;
  static const String globalType = 'MenubarTheme';
  static const MenubarThemeDefaults defaults = MenubarThemeDefaults();
  static const MenubarThemeTokens tokens = menubarThemeTokens;

  static T? resolve<T extends MenubarTheme>() {
    if (T == MenubarTheme) {
      return global as T?;
    }
    return null;
  }
}
