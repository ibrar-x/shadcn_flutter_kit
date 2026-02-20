// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'code_snippet_theme_defaults.dart';
import 'code_snippet_theme_tokens.dart';

class CodeSnippetThemeConfig {
  const CodeSnippetThemeConfig._();

  static const Object? global = null;
  static const String globalType = 'CodeSnippetTheme';
  static const CodeSnippetThemeDefaults defaults = CodeSnippetThemeDefaults();
  static const CodeSnippetThemeTokens tokens = codeSnippetThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == globalType) {
      return global as T?;
    }
    return null;
  }
}
