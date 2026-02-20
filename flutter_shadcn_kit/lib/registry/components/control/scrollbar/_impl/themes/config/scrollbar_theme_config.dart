// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'scrollbar_theme_defaults.dart';
import 'scrollbar_theme_tokens.dart';

class ScrollbarThemeConfig {
  const ScrollbarThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'ScrollbarTheme';
  static const ScrollbarThemeDefaults defaults = ScrollbarThemeDefaults();
  static const ScrollbarThemeTokens tokens = scrollbarThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
