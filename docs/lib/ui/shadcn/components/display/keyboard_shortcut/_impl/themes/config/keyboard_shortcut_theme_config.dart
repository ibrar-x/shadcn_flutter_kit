// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../keyboard_shortcut.dart';
import 'keyboard_shortcut_theme_defaults.dart';
import 'keyboard_shortcut_theme_tokens.dart';

class KeyboardShortcutThemeConfig {
  const KeyboardShortcutThemeConfig._();

  static const KeyboardShortcutTheme? global = null;
  static const String globalType = 'KeyboardShortcutTheme';
  static const KeyboardShortcutThemeDefaults defaults =
      KeyboardShortcutThemeDefaults();
  static const KeyboardShortcutThemeTokens tokens = keyboardShortcutThemeTokens;

  static T? resolve<T extends KeyboardShortcutTheme>() {
    if (T == KeyboardShortcutTheme) {
      return global as T?;
    }
    return null;
  }
}
