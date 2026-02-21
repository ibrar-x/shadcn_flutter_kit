// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../stepper.dart';
import 'stepper_theme_defaults.dart';
import 'stepper_theme_tokens.dart';

class StepperThemeConfig {
  const StepperThemeConfig._();

  static const StepperTheme? global = null;
  static const String globalType = 'StepperTheme';
  static const StepperThemeDefaults defaults = StepperThemeDefaults();
  static const StepperThemeTokens tokens = stepperThemeTokens;

  static T? resolve<T extends StepperTheme>() {
    if (T == StepperTheme) {
      return global as T?;
    }
    return null;
  }
}
