// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'multiple_choice_theme_defaults.dart';
import 'multiple_choice_theme_tokens.dart';

class MultipleChoiceThemeConfig {
  const MultipleChoiceThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'MultipleChoiceTheme';
  static const MultipleChoiceThemeDefaults defaults =
      MultipleChoiceThemeDefaults();
  static const MultipleChoiceThemeTokens tokens = multipleChoiceThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
