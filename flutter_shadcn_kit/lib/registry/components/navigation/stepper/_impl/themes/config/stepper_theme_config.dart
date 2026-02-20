// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'stepper_theme_defaults.dart';
import 'stepper_theme_tokens.dart';

class StepperThemeConfig {
  const StepperThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'StepperTheme';
  static const StepperThemeDefaults defaults = StepperThemeDefaults();
  static const StepperThemeTokens tokens = stepperThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
