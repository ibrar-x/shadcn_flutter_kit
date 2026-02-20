// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'navigation_bar_theme_defaults.dart';
import 'navigation_bar_theme_tokens.dart';

class NavigationBarThemeConfig {
  const NavigationBarThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'NavigationBarTheme';
  static const NavigationBarThemeDefaults defaults = NavigationBarThemeDefaults();
  static const NavigationBarThemeTokens tokens = navigationBarThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
