import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/command/command.dart'
    as shadcn_command;

const ComponentExample commandBasicExample = ComponentExample(
  title: 'Command palette',
  builder: _buildCommandBasicExample,
  code: '''
Command(
  builder: (context, query) async* {
    final items = {
      'Suggestions': ['Calendar', 'Search Emoji', 'Launch'],
      'Settings': ['Profile', 'Mail', 'Settings'],
    };

    yield [
      for (final entry in items.entries)
        CommandCategory(
          title: Text(entry.key),
          children: [
            for (final item in entry.value)
              CommandItem(
                leading: Icon(Icons.circle_outlined),
                title: Text(item),
                onTap: () {},
              ),
          ],
        ),
    ];
  },
)
''',
);

Widget _buildCommandBasicExample(BuildContext context) {
  return const SizedBox(
    width: 320,
    height: 320,
    child: _CommandBasicExample(),
  );
}

class _CommandBasicExample extends StatelessWidget {
  const _CommandBasicExample();

  @override
  Widget build(BuildContext context) {
    return const shadcn_command.Command(
      searchPlaceholder: Text('Type a command or search...'),
      builder: _buildCommandResults,
    );
  }
}

Stream<List<Widget>> _buildCommandResults(
  BuildContext context,
  String? query,
) async* {
  final items = <String, List<String>>{
    'Suggestions': ['Calendar', 'Search Emoji', 'Launch'],
    'Settings': ['Profile', 'Mail', 'Settings'],
  };
  final icons = <String, IconData>{
    'Calendar': Icons.calendar_today_outlined,
    'Search Emoji': Icons.emoji_emotions_outlined,
    'Launch': Icons.rocket_launch_outlined,
    'Profile': Icons.person_outline,
    'Mail': Icons.mail_outline,
    'Settings': Icons.settings_outlined,
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
            leading: Icon(icons[item]),
            title: Text(item),
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
