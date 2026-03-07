import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/markdown/markdown.dart'
    as shadcn_markdown;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

class MarkdownExampleTheme extends StatelessWidget {
  const MarkdownExampleTheme({super.key});

  static const String _content = '''## Themed Markdown

Use `ComponentTheme` to customize markdown visuals.

```dart
final markdown = Markdown(data: source);
```

> Quotes, tables, headings, and code fences all read from `MarkdownTheme`.
''';

  @override
  Widget build(BuildContext context) {
    return const shadcn_theme.ComponentTheme(
      data: shadcn_markdown.MarkdownTheme(
        linkStyle: TextStyle(
          color: Color(0xFF0E7490),
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w600,
        ),
        quoteBorderColor: Color(0xFFD97706),
        quoteBackgroundColor: Color(0xFFFFFBEB),
        tableHeaderBackgroundColor: Color(0xFFF8F5EE),
        tableBorderColor: Color(0xFFD6C5AB),
        codeBackgroundColor: Color(0xFFF5EEE2),
      ),
      child: SizedBox(
        width: 560,
        child: shadcn_markdown.Markdown(
          data: _content,
          selectable: true,
          followLinks: true,
        ),
      ),
    );
  }
}
