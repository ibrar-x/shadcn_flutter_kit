// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../toast.dart';
import 'toast_theme_defaults.dart';
import 'toast_theme_tokens.dart';

class ToastThemeConfig {
  const ToastThemeConfig._();

  static const ToastTheme? global = null;
  static const String globalType = 'ToastTheme';
  static const ToastThemeDefaults defaults = ToastThemeDefaults();
  static const ToastThemeTokens tokens = toastThemeTokens;

  static T? resolve<T extends ToastTheme>() {
    if (T == ToastTheme) {
      return global as T?;
    }
    return null;
  }
}
