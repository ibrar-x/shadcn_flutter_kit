// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../switch.dart';
import 'switch_theme_defaults.dart';
import 'switch_theme_tokens.dart';

class SwitchThemeConfig {
  const SwitchThemeConfig._();

  static const SwitchTheme? global = null;
  static const String globalType = 'SwitchTheme';
  static const SwitchThemeDefaults defaults = SwitchThemeDefaults();
  static const SwitchThemeTokens tokens = switchThemeTokens;

  static T? resolve<T extends SwitchTheme>() {
    if (T == SwitchTheme) {
      return global as T?;
    }
    return null;
  }
}
