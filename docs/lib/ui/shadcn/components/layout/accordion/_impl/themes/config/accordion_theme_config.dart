// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../accordion.dart';
import 'accordion_theme_defaults.dart';
import 'accordion_theme_tokens.dart';

class AccordionThemeConfig {
  const AccordionThemeConfig._();

  static const AccordionTheme? global = null;
  static const String globalType = 'AccordionTheme';
  static const AccordionThemeDefaults defaults = AccordionThemeDefaults();
  static const AccordionThemeTokens tokens = accordionThemeTokens;

  static T? resolve<T extends AccordionTheme>() {
    if (T == AccordionTheme) {
      return global as T?;
    }
    return null;
  }
}
