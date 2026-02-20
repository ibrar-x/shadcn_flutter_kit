// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'spinner_theme_defaults.dart';
import 'spinner_theme_tokens.dart';

class SpinnerThemeConfig {
  const SpinnerThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'SpinnerTheme';
  static const SpinnerThemeDefaults defaults = SpinnerThemeDefaults();
  static const SpinnerThemeTokens tokens = spinnerThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
