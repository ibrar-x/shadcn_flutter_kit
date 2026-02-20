// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'phone_input_theme_defaults.dart';
import 'phone_input_theme_tokens.dart';

class PhoneInputThemeConfig {
  const PhoneInputThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'PhoneInputTheme';
  static const PhoneInputThemeDefaults defaults = PhoneInputThemeDefaults();
  static const PhoneInputThemeTokens tokens = phoneInputThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
