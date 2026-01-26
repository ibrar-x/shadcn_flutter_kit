import 'package:flutter/material.dart';

import '../docs_page.dart';
import 'blocks.dart';
import '../../ui/shadcn/shared/primitives/text.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OnThisPage headingsKey = OnThisPage();
    final OnThisPage bodyKey = OnThisPage();
    final OnThisPage modifiersKey = OnThisPage();

    return DocsPage(
      name: 'typography',
      onThisPage: {
        'Headings': headingsKey,
        'Body': bodyKey,
        'Modifiers': modifiersKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Typography').h1(),
          const SizedBox(height: 12),
          const DocsParagraph(
            text:
                'Text styling is provided through extensions on Widget. Use chained modifiers to create headings, captions, and inline emphasis without custom TextStyle boilerplate.',
          ),
          DocsSectionTitle(title: 'Headings', anchor: headingsKey),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Heading 1').h1(),
              const SizedBox(height: 6),
              const Text('Heading 2').h2(),
              const SizedBox(height: 6),
              const Text('Heading 3').h3(),
            ],
          ),
          const SizedBox(height: 16),
          DocsSectionTitle(title: 'Body', anchor: bodyKey),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Lead paragraph example text.').lead(),
              const SizedBox(height: 8),
              const Text('Base body text for standard copy.').base(),
              const SizedBox(height: 8),
              const Text('Muted helper text for captions.').muted(),
            ],
          ),
          const SizedBox(height: 16),
          DocsSectionTitle(title: 'Modifiers', anchor: modifiersKey),
          const SizedBox(height: 12),
          const DocsParagraph(
            text:
                'Modifiers can be chained to control size, weight, and font family. Example usage is shown below.',
          ),
          const DocsCodeBlock(
            code: "Text('Example').sans.small.semiBold();",
          ),
        ],
      ),
    );
  }
}
