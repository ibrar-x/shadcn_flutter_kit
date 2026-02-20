// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'skeleton_theme_defaults.dart';
import 'skeleton_theme_tokens.dart';

class SkeletonThemeConfig {
  const SkeletonThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'SkeletonTheme';
  static const SkeletonThemeDefaults defaults = SkeletonThemeDefaults();
  static const SkeletonThemeTokens tokens = skeletonThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
