// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'badge_theme_defaults.dart';
import 'badge_theme_tokens.dart';

class BadgeThemeConfig {
  const BadgeThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'BadgeTheme';
  static const BadgeThemeDefaults defaults = BadgeThemeDefaults();
  static const BadgeThemeTokens tokens = badgeThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
