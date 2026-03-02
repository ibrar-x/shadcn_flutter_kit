import 'package:flutter/material.dart';

import '../docs_page.dart';
import 'blocks.dart';
import '../../ui/shadcn/shared/primitives/text.dart';

class StatePage extends StatelessWidget {
  const StatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'state',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('State Management').h1(),
          const SizedBox(height: 8),
          const DocsParagraph(
            text:
                'shadcn_flutter components are state-management agnostic. You can use setState, ValueNotifier, Provider, Riverpod, Bloc, or any architecture that fits your app.',
          ),
          const DocsSectionTitle(title: 'Recommended approach'),
          const SizedBox(height: 8),
          const DocsBulletList(
            items: [
              'Keep local UI state close to the component for quick interactions.',
              'Lift shared state into your app-level state solution when multiple screens depend on it.',
              'Persist theme and user preferences centrally so docs-like controls stay in sync.',
            ],
          ),
          const SizedBox(height: 16),
          const DocsSectionTitle(title: 'Example'),
          const SizedBox(height: 8),
          const DocsCodeBlock(
            code: '''
class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () => setState(() => count += 1),
      child: Text('Count: \$count'),
    );
  }
}
''',
          ),
        ],
      ),
    );
  }
}
