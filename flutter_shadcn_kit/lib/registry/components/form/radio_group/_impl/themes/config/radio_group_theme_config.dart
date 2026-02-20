// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'radio_group_theme_defaults.dart';
import 'radio_group_theme_tokens.dart';

class RadioGroupThemeConfig {
  const RadioGroupThemeConfig._();

  static const Object? radioCardTheme = null;
  static const String radioCardThemeType = 'RadioCardTheme';
  static const RadioCardThemeDefaults radioCardThemeDefaults =
      RadioCardThemeDefaults();
  static const RadioCardThemeTokens radioCardThemeTokenConfig =
      radioCardThemeTokens;

  static const Object? radioTheme = null;
  static const String radioThemeType = 'RadioTheme';
  static const RadioThemeDefaults radioThemeDefaults = RadioThemeDefaults();
  static const RadioThemeTokens radioThemeTokenConfig = radioThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == radioCardThemeType) {
      return radioCardTheme as T?;
    }
    if (T.toString() == radioThemeType) {
      return radioTheme as T?;
    }
    return null;
  }
}
