import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'command_example_1.dart';

const ComponentExample commandExample1 = ComponentExample(
  title: "Command Example",
  builder: _buildCommandExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass CommandExample1 extends StatelessWidget {\n  const CommandExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Command(\n      // The builder is an async generator producing lists of CommandCategory\n      // based on the current search query. Each yield updates the UI.\n      builder: (context, query) async* {\n        Map<String, List<String>> items = {\n          'Suggestions': ['Calendar', 'Search Emoji', 'Launch'],\n          'Settings': ['Profile', 'Mail', 'Settings'],\n        };\n        Map<String, Widget> icons = {\n          'Calendar': const Icon(Icons.calendar_today),\n          'Search Emoji': const Icon(Icons.emoji_emotions_outlined),\n          'Launch': const Icon(Icons.rocket_launch_outlined),\n          'Profile': const Icon(Icons.person_outline),\n          'Mail': const Icon(Icons.mail_outline),\n          'Settings': const Icon(Icons.settings_outlined),\n        };\n        for (final values in items.entries) {\n          List<Widget> resultItems = [];\n          for (final item in values.value) {\n            if (query == null ||\n                item.toLowerCase().contains(query.toLowerCase())) {\n              resultItems.add(CommandItem(\n                title: Text(item),\n                leading: icons[item],\n                onTap: () {},\n              ));\n            }\n          }\n          if (resultItems.isNotEmpty) {\n            // Simulate latency to showcase incremental results.\n            await Future.delayed(const Duration(seconds: 1));\n            yield [\n              CommandCategory(\n                title: Text(values.key),\n                children: resultItems,\n              ),\n            ];\n          }\n        }\n      },\n    ).sized(width: 300, height: 300);\n  }\n}\n",
);

Widget _buildCommandExample1(BuildContext context) {
  return const CommandExample1();
}

const List<ComponentExample> commandExamples = [
  commandExample1,
];
