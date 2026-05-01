// GENERATED FILE - DO NOT EDIT.
// Update via docs/scripts/generate_component_pages.py.

import 'package:flutter/material.dart';
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/ui/shadcn/components/display/markdown/preview.dart';

class MarkdownDocsPage extends StatelessWidget {
  const MarkdownDocsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'markdown',
      displayName: 'Markdown',
      description: 'Advanced markdown renderer with asset/file sources and optional streaming support.',
      children: [
        MarkdownPreview(),
      ],
    );
  }
}
