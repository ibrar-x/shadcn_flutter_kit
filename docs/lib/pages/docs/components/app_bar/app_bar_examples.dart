import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'app_bar_example_1.dart';

const ComponentExample appBarExample1 = ComponentExample(
  title: "Example 1",
  builder: _buildAppBarExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// AppBar with header, title, subtitle, and action buttons.\n///\n/// Demonstrates the structure of [AppBar] and how to provide leading and\n/// trailing actions using outline-styled icon buttons.\nclass AppBarExample1 extends StatelessWidget {\n  const AppBarExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return OutlinedContainer(\n      clipBehavior: Clip.antiAlias,\n      child: AppBar(\n        // Optional top line above the main title area.\n        header: const Text('This is Header'),\n        // Primary title and an optional subtitle.\n        title: const Text('This is Title'),\n        subtitle: const Text('This is Subtitle'),\n        leading: [\n          // Leading actions typically appear on the left.\n          OutlineButton(\n            density: ButtonDensity.icon,\n            onPressed: () {},\n            child: const Icon(Icons.arrow_back),\n          ),\n        ],\n        trailing: [\n          // Trailing actions typically appear on the right.\n          OutlineButton(\n            density: ButtonDensity.icon,\n            onPressed: () {},\n            child: const Icon(Icons.search),\n          ),\n          OutlineButton(\n            density: ButtonDensity.icon,\n            onPressed: () {},\n            child: const Icon(Icons.more_vert),\n          ),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildAppBarExample1(BuildContext context) {
  return const AppBarExample1();
}

const List<ComponentExample> appBarExamples = [
  appBarExample1,
];
