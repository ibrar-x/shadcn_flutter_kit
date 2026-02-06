import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'tab_list_example_1.dart';

const ComponentExample tabListExample1 = ComponentExample(
  title: "Tab List Example",
  builder: _buildTabListExample1,
  code: "import 'package:docs/pages/docs/components/carousel_example.dart';\nimport 'package:docs/shadcn_ui.dart';\n\n// Demonstrates TabList (a low-level tab header) with an IndexedStack body.\n// The header controls the index; the content is managed separately.\n\nclass TabListExample1 extends StatefulWidget {\n  const TabListExample1({super.key});\n\n  @override\n  State<TabListExample1> createState() => _TabListExample1State();\n}\n\nclass _TabListExample1State extends State<TabListExample1> {\n  int index = 0;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      crossAxisAlignment: CrossAxisAlignment.stretch,\n      children: [\n        TabList(\n          // TabList is a lower-level tab header; it doesn't manage content.\n          index: index,\n          onChanged: (value) {\n            setState(() {\n              index = value;\n            });\n          },\n          children: const [\n            TabItem(\n              child: Text('Tab 1'),\n            ),\n            TabItem(\n              child: Text('Tab 2'),\n            ),\n            TabItem(\n              child: Text('Tab 3'),\n            ),\n          ],\n        ),\n        const Gap(16),\n        // Like Tabs example, use an IndexedStack to switch the content area.\n        IndexedStack(\n          index: index,\n          children: const [\n            NumberedContainer(\n              index: 1,\n            ),\n            NumberedContainer(\n              index: 2,\n            ),\n            NumberedContainer(\n              index: 3,\n            ),\n          ],\n        ).sized(height: 300),\n      ],\n    );\n  }\n}\n",
);

Widget _buildTabListExample1(BuildContext context) {
  return const TabListExample1();
}

const List<ComponentExample> tabListExamples = [
  tabListExample1,
];
