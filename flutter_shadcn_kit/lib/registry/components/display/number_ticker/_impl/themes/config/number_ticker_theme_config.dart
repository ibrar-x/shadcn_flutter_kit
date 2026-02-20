// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'number_ticker_theme_defaults.dart';
import 'number_ticker_theme_tokens.dart';

class NumberTickerThemeConfig {
  const NumberTickerThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'NumberTickerTheme';
  static const NumberTickerThemeDefaults defaults = NumberTickerThemeDefaults();
  static const NumberTickerThemeTokens tokens = numberTickerThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
