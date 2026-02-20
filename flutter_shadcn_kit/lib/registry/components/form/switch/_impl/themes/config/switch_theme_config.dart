// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'switch_theme_defaults.dart';
import 'switch_theme_tokens.dart';

class SwitchThemeConfig {
  const SwitchThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'SwitchTheme';
  static const SwitchThemeDefaults defaults = SwitchThemeDefaults();
  static const SwitchThemeTokens tokens = switchThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
