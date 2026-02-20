// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'progress_theme_defaults.dart';
import 'progress_theme_tokens.dart';

class ProgressThemeConfig {
  const ProgressThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'ProgressTheme';
  static const ProgressThemeDefaults defaults = ProgressThemeDefaults();
  static const ProgressThemeTokens tokens = progressThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
