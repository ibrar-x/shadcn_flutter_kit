import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'markdown_example_basic.dart';
import 'markdown_example_theme.dart';

const ComponentExample markdownExampleBasic = ComponentExample(
  title: 'Basic Markdown Rendering',
  builder: _buildMarkdownExampleBasic,
  code:
      '''import 'package:docs/ui/shadcn/components/display/markdown/markdown.dart';

const Markdown(
  data: '# Markdown Basics\\n\\nUse **bold**, *italic*, tables, code, and links.',
  selectable: true,
  followLinks: true,
);

// Tip: pair this with the text_animate streaming extension when rendering tokens live.''',
);

Widget _buildMarkdownExampleBasic(BuildContext context) {
  return const MarkdownExampleBasic();
}

const ComponentExample markdownExampleTheme = ComponentExample(
  title: 'Markdown Theme Override',
  builder: _buildMarkdownExampleTheme,
  code: '''ComponentTheme(
  data: const MarkdownTheme(
    quoteBorderColor: Color(0xFFD97706),
    codeBackgroundColor: Color(0xFFF5EEE2),
    tableHeaderBackgroundColor: Color(0xFFF8F5EE),
  ),
  child: const Markdown(data: source),
);''',
);

Widget _buildMarkdownExampleTheme(BuildContext context) {
  return const MarkdownExampleTheme();
}

const List<ComponentExample> markdownExamples = [
  markdownExampleBasic,
  markdownExampleTheme,
];
