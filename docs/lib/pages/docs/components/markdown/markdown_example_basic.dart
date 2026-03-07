import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/markdown/markdown.dart'
    as shadcn_markdown;

class MarkdownExampleBasic extends StatelessWidget {
  const MarkdownExampleBasic({super.key});

  static const String _content = '''# Markdown Basics

This paragraph mixes **bold**, *italic*, and `inline code`.

- Lists render with spacing.
- Links are tappable: [Flutter](https://flutter.dev)
- Tables are supported.

| Feature | Status |
| :-- | :-- |
| Headings | ready |
| Tables | ready |

> Note: Markdown can be paired with the streaming text extension when you need live token rendering.
''';

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 560,
      child: shadcn_markdown.Markdown(
        data: _content,
        selectable: true,
        followLinks: true,
      ),
    );
  }
}
