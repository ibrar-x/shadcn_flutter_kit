// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import '../../../table.dart';
import 'table_theme_defaults.dart';
import 'table_theme_tokens.dart';

class TableThemeConfig {
  const TableThemeConfig._();

  static const TableTheme? global = null;
  static const String globalType = 'TableTheme';
  static const TableThemeDefaults defaults = TableThemeDefaults();
  static const TableThemeTokens tokens = tableThemeTokens;

  static const ResizableTableTheme? resizableTableTheme = null;
  static const String resizableTableThemeType = 'ResizableTableTheme';
  static const ResizableTableThemeDefaults resizableTableThemeDefaults =
      ResizableTableThemeDefaults();
  static const ResizableTableThemeTokens resizableTableThemeTokenConfig =
      resizableTableThemeTokens;

  static T? resolve<T>() {
    if (T == TableTheme) {
      return global as T?;
    }
    if (T == ResizableTableTheme) {
      return resizableTableTheme as T?;
    }
    return null;
  }
}
