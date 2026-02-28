// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../alert.dart';
import 'alert_theme_defaults.dart';
import 'alert_theme_tokens.dart';

class AlertThemeConfig {
  const AlertThemeConfig._();

  static const AlertTheme? global = null;
  static const String globalType = 'AlertTheme';
  static const AlertThemeDefaults defaults = AlertThemeDefaults();
  static const AlertThemeTokens tokens = alertThemeTokens;

  static T? resolve<T extends AlertTheme>() {
    if (T == AlertTheme) {
      return global as T?;
    }
    return null;
  }
}
