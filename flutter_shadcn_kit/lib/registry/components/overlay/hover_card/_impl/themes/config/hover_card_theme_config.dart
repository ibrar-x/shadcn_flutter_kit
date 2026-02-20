// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'hover_card_theme_defaults.dart';
import 'hover_card_theme_tokens.dart';

class HoverCardThemeConfig {
  const HoverCardThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'HoverCardTheme';
  static const HoverCardThemeDefaults defaults = HoverCardThemeDefaults();
  static const HoverCardThemeTokens tokens = hoverCardThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
