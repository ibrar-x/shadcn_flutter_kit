import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/command/command.dart'
    as shadcn_command;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample commandEmptyExample = ComponentExample(
  title: 'Empty state',
  builder: _buildCommandEmptyExample,
  code: '''
Command(
  emptyBuilder: (context) => Text('No matches').muted(),
  builder: (context, query) async* {
    yield const [];
  },
)
''',
);

Widget _buildCommandEmptyExample(BuildContext context) {
  return const SizedBox(
    width: 320,
    height: 260,
    child: _CommandEmptyExample(),
  );
}

class _CommandEmptyExample extends StatelessWidget {
  const _CommandEmptyExample();

  @override
  Widget build(BuildContext context) {
    return shadcn_command.Command(
      searchPlaceholder: const Text('Search shortcuts...'),
      emptyBuilder: (context) => const Text('No matches found').muted(),
      builder: _buildEmptyResults,
    );
  }
}

Stream<List<Widget>> _buildEmptyResults(
  BuildContext context,
  String? query,
) async* {
  yield const [];
}
