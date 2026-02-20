// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'focus_outline_theme_defaults.dart';
import 'focus_outline_theme_tokens.dart';

class FocusOutlineThemeConfig {
  const FocusOutlineThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'FocusOutlineTheme';
  static const FocusOutlineThemeDefaults defaults = FocusOutlineThemeDefaults();
  static const FocusOutlineThemeTokens tokens = focusOutlineThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
