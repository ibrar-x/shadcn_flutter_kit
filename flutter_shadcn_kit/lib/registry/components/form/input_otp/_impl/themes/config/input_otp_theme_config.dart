// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'input_otp_theme_defaults.dart';
import 'input_otp_theme_tokens.dart';

class InputOtpThemeConfig {
  const InputOtpThemeConfig._();

  static const Object? inputOTPTheme = null;
  static const String inputOTPThemeType = 'InputOTPTheme';
  static const InputOTPThemeDefaults inputOTPThemeDefaults =
      InputOTPThemeDefaults();
  static const InputOTPThemeTokens inputOTPThemeTokenConfig =
      inputOTPThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == inputOTPThemeType) {
      return inputOTPTheme as T?;
    }
    return null;
  }
}
