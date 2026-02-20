// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'dialog_theme_defaults.dart';
import 'dialog_theme_tokens.dart';

class DialogThemeConfig {
  const DialogThemeConfig._();

  static const Object? modalBackdropTheme = null;
  static const String modalBackdropThemeType = 'ModalBackdropTheme';
  static const ModalBackdropThemeDefaults modalBackdropThemeDefaults =
      ModalBackdropThemeDefaults();
  static const ModalBackdropThemeTokens modalBackdropThemeTokenConfig =
      modalBackdropThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == modalBackdropThemeType) {
      return modalBackdropTheme as T?;
    }
    return null;
  }
}
