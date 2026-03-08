import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'markdown_example_basic.dart';
import 'markdown_example_complex.dart';
import 'markdown_example_editor.dart';
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
  code: '''ComponentTheme<MarkdownTheme>(
  data: const MarkdownTheme(
    heading1Style: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w900,
      color: Color(0xFF7C2D12),
    ),
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

const ComponentExample markdownExampleComplex = ComponentExample(
  title: 'Complex Markdown + Interaction Hooks',
  builder: _buildMarkdownExampleComplex,
  code: '''Markdown(
  data: markdown,
  selectable: true,
  followLinks: true,
  onTapLinkDetails: (details) {},
  onTapHeading: (details) {},
  onTapElement: (details) {},
);''',
);

Widget _buildMarkdownExampleComplex(BuildContext context) {
  return const MarkdownExampleComplex();
}

const ComponentExample markdownExampleEditor = ComponentExample(
  title: 'Editor + Live Preview (Registry Widgets)',
  builder: _buildMarkdownExampleEditor,
  code: '''final controller = MarkdownEditingController(text: seed);

MarkdownEditingBar(controller: controller);

TextField(controller: controller, maxLines: null, expands: true);

MarkdownLivePreview(
  controller: controller,
  debounce: Duration(milliseconds: 110),
);''',
);

Widget _buildMarkdownExampleEditor(BuildContext context) {
  return const MarkdownExampleEditor();
}

const List<ComponentExample> markdownExamples = [
  markdownExampleBasic,
  markdownExampleTheme,
  markdownExampleComplex,
  markdownExampleEditor,
];
