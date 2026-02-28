// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../context_menu.dart';
import 'context_menu_theme_defaults.dart';
import 'context_menu_theme_tokens.dart';

class ContextMenuThemeConfig {
  const ContextMenuThemeConfig._();

  static const ContextMenuTheme? global = null;
  static const String globalType = 'ContextMenuTheme';
  static const ContextMenuThemeDefaults defaults = ContextMenuThemeDefaults();
  static const ContextMenuThemeTokens tokens = contextMenuThemeTokens;

  static T? resolve<T extends ContextMenuTheme>() {
    if (T == ContextMenuTheme) {
      return global as T?;
    }
    return null;
  }
}
