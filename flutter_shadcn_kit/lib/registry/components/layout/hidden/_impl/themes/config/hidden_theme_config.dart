// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'hidden_theme_defaults.dart';
import 'hidden_theme_tokens.dart';

class HiddenThemeConfig {
  const HiddenThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'HiddenTheme';
  static const HiddenThemeDefaults defaults = HiddenThemeDefaults();
  static const HiddenThemeTokens tokens = hiddenThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
