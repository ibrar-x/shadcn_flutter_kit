// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'dropdown_menu_theme_defaults.dart';
import 'dropdown_menu_theme_tokens.dart';

class DropdownMenuThemeConfig {
  const DropdownMenuThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'DropdownMenuTheme';
  static const DropdownMenuThemeDefaults defaults = DropdownMenuThemeDefaults();
  static const DropdownMenuThemeTokens tokens = dropdownMenuThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
