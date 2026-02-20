// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'checkbox_theme_defaults.dart';
import 'checkbox_theme_tokens.dart';

class CheckboxThemeConfig {
  const CheckboxThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'CheckboxTheme';
  static const CheckboxThemeDefaults defaults = CheckboxThemeDefaults();
  static const CheckboxThemeTokens tokens = checkboxThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
