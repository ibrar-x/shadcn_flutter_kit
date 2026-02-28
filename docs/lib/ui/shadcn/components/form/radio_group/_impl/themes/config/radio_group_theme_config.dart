// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../radio_group.dart';
import 'radio_group_theme_defaults.dart';
import 'radio_group_theme_tokens.dart';

class RadioGroupThemeConfig {
  const RadioGroupThemeConfig._();

  static const RadioCardTheme? radioCardTheme = null;
  static const String radioCardThemeType = 'RadioCardTheme';
  static const RadioCardThemeDefaults radioCardThemeDefaults =
      RadioCardThemeDefaults();
  static const RadioCardThemeTokens radioCardThemeTokenConfig =
      radioCardThemeTokens;

  static const RadioTheme? radioTheme = null;
  static const String radioThemeType = 'RadioTheme';
  static const RadioThemeDefaults radioThemeDefaults = RadioThemeDefaults();
  static const RadioThemeTokens radioThemeTokenConfig = radioThemeTokens;

  static T? resolve<T>() {
    if (T == RadioCardTheme) {
      return radioCardTheme as T?;
    }
    if (T == RadioTheme) {
      return radioTheme as T?;
    }
    return null;
  }
}
