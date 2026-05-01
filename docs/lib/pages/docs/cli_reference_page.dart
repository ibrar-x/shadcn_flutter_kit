import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../docs_page.dart';
import '../../ui/shadcn/shared/primitives/text.dart';
import 'blocks.dart';
import 'cli_reference_data.dart';

class CliReferencePage extends StatelessWidget {
  const CliReferencePage({
    super.key,
    required this.pageId,
  });

  final String pageId;

  @override
  Widget build(BuildContext context) {
    final doc = cliReferenceDocs[pageId] ?? cliReferenceDocs['cli-overview']!;
    final overviewKey = OnThisPage();
    final syntaxKey = OnThisPage();
    final optionsKey = OnThisPage();
    final examplesKey = OnThisPage();
    final behaviorKey = OnThisPage();
    final relatedKey = OnThisPage();

    final onThisPage = <String, OnThisPage>{
      'Overview': overviewKey,
      if (doc.syntax.isNotEmpty) 'Syntax': syntaxKey,
      if (doc.options.isNotEmpty) 'Options': optionsKey,
      if (doc.examples.isNotEmpty) 'Examples': examplesKey,
      if (doc.behavior.isNotEmpty) 'Behavior': behaviorKey,
      if (doc.related.isNotEmpty) 'Related': relatedKey,
    };

    return DocsPage(
      name: doc.id,
      sidebarMode: DocsSidebarMode.cli,
      onThisPage: onThisPage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageItemWidget(
            onThisPage: overviewKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc.title).h1(),
                const SizedBox(height: 12),
                DocsParagraph(text: doc.summary),
              ],
            ),
          ),
          if (doc.syntax.isNotEmpty) ...[
            const SizedBox(height: 20),
            DocsSectionTitle(title: 'Syntax', anchor: syntaxKey),
            const SizedBox(height: 12),
            for (final syntax in doc.syntax) ...[
              DocsCodeBlock(code: syntax, mode: 'bash'),
              const SizedBox(height: 12),
            ],
          ],
          if (doc.options.isNotEmpty) ...[
            const SizedBox(height: 20),
            DocsSectionTitle(title: 'Options', anchor: optionsKey),
            const SizedBox(height: 12),
            DocsOptionsTable(rows: doc.options),
          ],
          if (doc.examples.isNotEmpty) ...[
            const SizedBox(height: 20),
            DocsSectionTitle(title: 'Examples', anchor: examplesKey),
            const SizedBox(height: 12),
            for (final example in doc.examples) ...[
              Text(example.title).base().semiBold(),
              const SizedBox(height: 6),
              DocsParagraph(text: example.description),
              DocsCodeBlock(code: example.command, mode: 'bash'),
              const SizedBox(height: 16),
            ],
          ],
          if (doc.behavior.isNotEmpty) ...[
            const SizedBox(height: 12),
            DocsSectionTitle(title: 'Behavior', anchor: behaviorKey),
            const SizedBox(height: 12),
            DocsBulletList(items: doc.behavior),
          ],
          if (doc.related.isNotEmpty) ...[
            const SizedBox(height: 20),
            DocsSectionTitle(title: 'Related', anchor: relatedKey),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final relatedId in doc.related)
                  OutlinedButton(
                    onPressed: () => context.goNamed(
                      'cli_reference',
                      pathParameters: {'id': relatedId},
                    ),
                    child: Text(
                      cliReferenceDocs[relatedId]?.title ?? relatedId,
                    ).small(),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
