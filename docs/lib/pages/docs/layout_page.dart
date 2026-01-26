import 'package:flutter/material.dart';

import '../docs_page.dart';
import 'blocks.dart';
import '../../ui/shadcn/components/layout/outlined_container/outlined_container.dart';
import '../../ui/shadcn/shared/primitives/text.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  Widget _exampleCard({required Widget child}) {
    return OutlinedContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final OnThisPage paddingKey = OnThisPage();
    final OnThisPage centerKey = OnThisPage();
    final OnThisPage gappedColumnKey = OnThisPage();
    final OnThisPage gappedRowKey = OnThisPage();
    final OnThisPage separatedColumnKey = OnThisPage();
    final OnThisPage separatedRowKey = OnThisPage();
    final OnThisPage basicLayoutKey = OnThisPage();

    return DocsPage(
      name: 'layout',
      onThisPage: {
        'Padding': paddingKey,
        'Center': centerKey,
        'Gapped Column': gappedColumnKey,
        'Gapped Row': gappedRowKey,
        'Separated Column': separatedColumnKey,
        'Separated Row': separatedRowKey,
        'Basic Layout': basicLayoutKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Layout').h1(),
          const SizedBox(height: 8),
          const DocsParagraph(
            text:
                'Layout helpers build on Flutter primitives while matching the registry spacing scale. Use them to keep spacing and structure consistent across docs pages.',
          ),
          DocsSectionTitle(title: 'Padding', anchor: paddingKey),
          const SizedBox(height: 12),
          _exampleCard(
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black12,
              child: const Text('Padded container').small(),
            ),
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Center', anchor: centerKey),
          const SizedBox(height: 12),
          _exampleCard(
            child: SizedBox(
              height: 80,
              child: Center(child: const Text('Centered content').small()),
            ),
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Gapped Column', anchor: gappedColumnKey),
          const SizedBox(height: 12),
          _exampleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('First item').small(),
                const SizedBox(height: 8),
                const Text('Second item').small(),
                const SizedBox(height: 8),
                const Text('Third item').small(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Gapped Row', anchor: gappedRowKey),
          const SizedBox(height: 12),
          _exampleCard(
            child: Row(
              children: [
                _pill('Row item A'),
                const SizedBox(width: 8),
                _pill('Row item B'),
                const SizedBox(width: 8),
                _pill('Row item C'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(
            title: 'Separated Column',
            anchor: separatedColumnKey,
          ),
          const SizedBox(height: 12),
          _exampleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Section 1').small(),
                const Divider(height: 24),
                const Text('Section 2').small(),
                const Divider(height: 24),
                const Text('Section 3').small(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Separated Row', anchor: separatedRowKey),
          const SizedBox(height: 12),
          _exampleCard(
            child: Row(
              children: [
                Expanded(child: const Text('Left').small()),
                const VerticalDivider(width: 24),
                Expanded(child: const Text('Middle').small()),
                const VerticalDivider(width: 24),
                Expanded(child: const Text('Right').small()),
              ],
            ),
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Basic Layout', anchor: basicLayoutKey),
          const SizedBox(height: 12),
          _exampleCard(
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 80,
                  color: Colors.black12,
                  child: Center(child: const Text('Sidebar').small()),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 80,
                    color: Colors.black12,
                    child: Center(child: const Text('Content').small()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label).small(),
    );
  }
}
