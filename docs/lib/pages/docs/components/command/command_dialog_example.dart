import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/control/command/command.dart'
    as shadcn_command;

const ComponentExample commandDialogExample = ComponentExample(
  title: 'Command dialog trigger',
  builder: _buildCommandDialogExample,
  code: '''
PrimaryButton(
  onPressed: () {
    showCommandDialog(
      context: context,
      builder: commandResults,
      constraints: BoxConstraints.tightFor(width: 480, height: 360),
    );
  },
  child: Text('Open command palette'),
)
''',
);

Widget _buildCommandDialogExample(BuildContext context) {
  return shadcn_buttons.PrimaryButton(
    onPressed: () {
      shadcn_command.showCommandDialog(
        context: context,
        constraints: const BoxConstraints.tightFor(width: 480, height: 360),
        builder: _buildCommandResults,
      );
    },
    child: const Text('Open command palette'),
  );
}

Stream<List<Widget>> _buildCommandResults(
  BuildContext context,
  String? query,
) async* {
  final items = <String, List<String>>{
    'Navigation': ['Dashboard', 'Components', 'Themes'],
    'Account': ['Profile', 'Billing', 'Settings'],
  };

  final List<Widget> categories = [];
  for (final entry in items.entries) {
    final List<Widget> rows = [];
    for (final item in entry.value) {
      if (query == null ||
          query.isEmpty ||
          item.toLowerCase().contains(query.toLowerCase())) {
        rows.add(
          shadcn_command.CommandItem(
            title: Text(item),
            leading: const Icon(Icons.circle_outlined),
            onTap: () {},
          ),
        );
      }
    }
    if (rows.isNotEmpty) {
      categories.add(
        shadcn_command.CommandCategory(
          title: Text(entry.key),
          children: rows,
        ),
      );
    }
  }

  yield categories;
}
