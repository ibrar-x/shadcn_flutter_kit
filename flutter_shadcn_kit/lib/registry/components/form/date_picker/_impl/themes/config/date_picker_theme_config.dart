// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'date_picker_theme_defaults.dart';
import 'date_picker_theme_tokens.dart';

class DatePickerThemeConfig {
  const DatePickerThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'DatePickerTheme';
  static const DatePickerThemeDefaults defaults = DatePickerThemeDefaults();
  static const DatePickerThemeTokens tokens = datePickerThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
