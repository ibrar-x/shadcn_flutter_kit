import 'package:flutter/material.dart';

import '../../../../ui/shadcn/components/display/markdown/markdown.dart'
    as shadcn_markdown;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

class MarkdownExampleTheme extends StatelessWidget {
  const MarkdownExampleTheme({super.key});

  static const String _content = '''# Themed Markdown

Use `ComponentTheme` to customize markdown visuals.

| Surface | Custom color |
| :-- | :-- |
| Quote border | Amber |
| Code background | Warm sand |
| Table header | Soft cream |

```dart
final markdown = Markdown(data: source);
```

> Quotes, tables, headings, and code fences all read from `MarkdownTheme`.
''';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseStyle = DefaultTextStyle.of(
      context,
    ).style.copyWith(fontSize: 15, height: 1.6);
    final onWarmSurface =
        isDark ? const Color(0xFFE5E7EB) : const Color(0xFF1F2937);
    final headingColor =
        isDark ? const Color(0xFFF59E0B) : const Color(0xFF7C2D12);
    final quoteBackground =
        isDark ? const Color(0xFF1F1A12) : const Color(0xFFFFFBEB);
    final tableHeaderBackground =
        isDark ? const Color(0xFF26221A) : const Color(0xFFF8F5EE);
    final tableBorder =
        isDark ? const Color(0xFF4B3F2A) : const Color(0xFFD6C5AB);
    final codeBackground =
        isDark ? const Color(0xFF1D1D1D) : const Color(0xFFF5EEE2);
    final codeLanguageColor =
        isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

    final themedMarkdown = shadcn_markdown.MarkdownTheme.htmlDefaults(
      baseStyle,
    ).copyWith(
      style: () => baseStyle,
      heading1Style: () => baseStyle.copyWith(
        fontSize: 34,
        height: 1.15,
        fontWeight: FontWeight.w900,
        color: headingColor,
        letterSpacing: -0.8,
      ),
      linkStyle: () => baseStyle.copyWith(
        color: const Color(0xFF0E7490),
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w700,
      ),
      codeStyle: () => TextStyle(
        fontFamily: 'GeistMono',
        fontSize: 13,
        height: 1.45,
        color: onWarmSurface,
      ),
      codeLanguageStyle: () => TextStyle(
        fontFamily: 'GeistMono',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: codeLanguageColor,
      ),
      quoteStyle: () => baseStyle.copyWith(
        color: onWarmSurface,
        height: 1.55,
      ),
      tableHeaderStyle: () => baseStyle.copyWith(
        color: onWarmSurface,
        fontWeight: FontWeight.w700,
      ),
      quoteBorderColor: () => const Color(0xFFD97706),
      quoteBackgroundColor: () => quoteBackground,
      tableHeaderBackgroundColor: () => tableHeaderBackground,
      tableBorderColor: () => tableBorder,
      codeBackgroundColor: () => codeBackground,
      tableRadius: () => BorderRadius.circular(14),
      codeRadius: () => BorderRadius.circular(12),
    );

    return shadcn_theme.ComponentTheme<shadcn_markdown.MarkdownTheme>(
      data: themedMarkdown,
      child: const SizedBox(
        width: 680,
        child: shadcn_markdown.Markdown(
            data: _content, selectable: true, followLinks: true),
      ),
    );
  }
}
