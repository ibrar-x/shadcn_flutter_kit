// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'time_picker_theme_defaults.dart';
import 'time_picker_theme_tokens.dart';

class TimePickerThemeConfig {
  const TimePickerThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'TimePickerTheme';
  static const TimePickerThemeDefaults defaults = TimePickerThemeDefaults();
  static const TimePickerThemeTokens tokens = timePickerThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
