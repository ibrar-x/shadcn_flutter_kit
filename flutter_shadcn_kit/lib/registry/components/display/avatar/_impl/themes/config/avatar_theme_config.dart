// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../avatar.dart';
import 'avatar_theme_defaults.dart';
import 'avatar_theme_tokens.dart';

class AvatarThemeConfig {
  const AvatarThemeConfig._();

  static const AvatarTheme? global = null;
  static const String globalType = 'AvatarTheme';
  static const AvatarThemeDefaults defaults = AvatarThemeDefaults();
  static const AvatarThemeTokens tokens = avatarThemeTokens;

  static T? resolve<T extends AvatarTheme>() {
    if (T == AvatarTheme) {
      return global as T?;
    }
    return null;
  }
}
