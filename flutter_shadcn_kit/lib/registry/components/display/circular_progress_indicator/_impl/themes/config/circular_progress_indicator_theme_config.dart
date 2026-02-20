// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'circular_progress_indicator_theme_defaults.dart';
import 'circular_progress_indicator_theme_tokens.dart';

class CircularProgressIndicatorThemeConfig {
  const CircularProgressIndicatorThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'CircularProgressIndicatorTheme';
  static const CircularProgressIndicatorThemeDefaults defaults =
      CircularProgressIndicatorThemeDefaults();
  static const CircularProgressIndicatorThemeTokens tokens =
      circularProgressIndicatorThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
