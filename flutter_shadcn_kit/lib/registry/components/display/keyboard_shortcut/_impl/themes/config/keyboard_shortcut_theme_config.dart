// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'keyboard_shortcut_theme_defaults.dart';
import 'keyboard_shortcut_theme_tokens.dart';

class KeyboardShortcutThemeConfig {
  const KeyboardShortcutThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'KeyboardShortcutTheme';
  static const KeyboardShortcutThemeDefaults defaults = KeyboardShortcutThemeDefaults();
  static const KeyboardShortcutThemeTokens tokens = keyboardShortcutThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
