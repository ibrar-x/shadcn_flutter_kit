// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'tooltip_theme_defaults.dart';
import 'tooltip_theme_tokens.dart';

class TooltipThemeConfig {
  const TooltipThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'TooltipTheme';
  static const TooltipThemeDefaults defaults = TooltipThemeDefaults();
  static const TooltipThemeTokens tokens = tooltipThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
