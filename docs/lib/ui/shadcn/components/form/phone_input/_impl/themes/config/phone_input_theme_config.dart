// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../phone_input.dart';
import 'phone_input_theme_defaults.dart';
import 'phone_input_theme_tokens.dart';

class PhoneInputThemeConfig {
  const PhoneInputThemeConfig._();

  static const PhoneInputTheme? global = null;
  static const String globalType = 'PhoneInputTheme';
  static const PhoneInputThemeDefaults defaults = PhoneInputThemeDefaults();
  static const PhoneInputThemeTokens tokens = phoneInputThemeTokens;

  static T? resolve<T extends PhoneInputTheme>() {
    if (T == PhoneInputTheme) {
      return global as T?;
    }
    return null;
  }
}
