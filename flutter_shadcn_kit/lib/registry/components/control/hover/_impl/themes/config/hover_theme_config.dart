// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../hover.dart';
import 'hover_theme_defaults.dart';
import 'hover_theme_tokens.dart';

class HoverThemeConfig {
  const HoverThemeConfig._();

  static const HoverTheme? global = null;
  static const String globalType = 'HoverTheme';
  static const HoverThemeDefaults defaults = HoverThemeDefaults();
  static const HoverThemeTokens tokens = hoverThemeTokens;

  static T? resolve<T extends HoverTheme>() {
    if (T == HoverTheme) {
      return global as T?;
    }
    return null;
  }
}
