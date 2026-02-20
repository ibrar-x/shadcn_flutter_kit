// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'linear_progress_indicator_theme_defaults.dart';
import 'linear_progress_indicator_theme_tokens.dart';

class LinearProgressIndicatorThemeConfig {
  const LinearProgressIndicatorThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'LinearProgressIndicatorTheme';
  static const LinearProgressIndicatorThemeDefaults defaults = LinearProgressIndicatorThemeDefaults();
  static const LinearProgressIndicatorThemeTokens tokens = linearProgressIndicatorThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
