// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'accordion_theme_defaults.dart';
import 'accordion_theme_tokens.dart';

class AccordionThemeConfig {
  const AccordionThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'AccordionTheme';
  static const AccordionThemeDefaults defaults = AccordionThemeDefaults();
  static const AccordionThemeTokens tokens = accordionThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
