// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../scrollable.dart';
import 'scrollable_theme_defaults.dart';
import 'scrollable_theme_tokens.dart';

class ScrollableThemeConfig {
  const ScrollableThemeConfig._();

  static const ScrollableClientTheme? scrollableClientTheme = null;
  static const String scrollableClientThemeType = 'ScrollableClientTheme';
  static const ScrollableClientThemeDefaults scrollableClientThemeDefaults =
      ScrollableClientThemeDefaults();
  static const ScrollableClientThemeTokens scrollableClientThemeTokenConfig =
      scrollableClientThemeTokens;

  static T? resolve<T>() {
    if (T == ScrollableClientTheme) {
      return scrollableClientTheme as T?;
    }
    return null;
  }
}
