// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../error_system.dart';
import 'error_system_theme_defaults.dart';
import 'error_system_theme_tokens.dart';

class ErrorSystemThemeConfig {
  const ErrorSystemThemeConfig._();

  static const ErrorSystemTheme? global = null;
  static const String globalType = 'ErrorSystemTheme';
  static const ErrorSystemThemeDefaults defaults = ErrorSystemThemeDefaults();
  static const ErrorSystemThemeTokens tokens = errorSystemThemeTokens;

  static T? resolve<T extends ErrorSystemTheme>() {
    if (T == ErrorSystemTheme) {
      return global as T?;
    }
    return null;
  }
}
