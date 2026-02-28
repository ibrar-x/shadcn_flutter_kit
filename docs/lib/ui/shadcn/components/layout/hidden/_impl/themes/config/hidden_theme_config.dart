// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../hidden.dart';
import 'hidden_theme_defaults.dart';
import 'hidden_theme_tokens.dart';

class HiddenThemeConfig {
  const HiddenThemeConfig._();

  static const HiddenTheme? global = null;
  static const String globalType = 'HiddenTheme';
  static const HiddenThemeDefaults defaults = HiddenThemeDefaults();
  static const HiddenThemeTokens tokens = hiddenThemeTokens;

  static T? resolve<T extends HiddenTheme>() {
    if (T == HiddenTheme) {
      return global as T?;
    }
    return null;
  }
}
