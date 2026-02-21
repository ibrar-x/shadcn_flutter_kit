// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../stage_container.dart';
import 'stage_container_theme_defaults.dart';
import 'stage_container_theme_tokens.dart';

class StageContainerThemeConfig {
  const StageContainerThemeConfig._();

  static const StageContainerTheme? global = null;
  static const String globalType = 'StageContainerTheme';
  static const StageContainerThemeDefaults defaults =
      StageContainerThemeDefaults();
  static const StageContainerThemeTokens tokens = stageContainerThemeTokens;

  static T? resolve<T extends StageContainerTheme>() {
    if (T == StageContainerTheme) {
      return global as T?;
    }
    return null;
  }
}
