import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'tabs_example_1.dart';

const ComponentExample tabsExample1 = ComponentExample(
  title: "Tabs Example",
  builder: _buildTabsExample1,
  code: "import 'package:docs/pages/docs/components/carousel_example.dart';\nimport 'package:docs/shadcn_ui.dart';\n\n// Demonstrates Tabs as a header paired with an IndexedStack body.\n// Tabs manages the active index; the stack swaps content without unmounting.\n\nclass TabsExample1 extends StatefulWidget {\n  const TabsExample1({super.key});\n\n  @override\n  State<TabsExample1> createState() => _TabsExample1State();\n}\n\nclass _TabsExample1State extends State<TabsExample1> {\n  int index = 0;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        Tabs(\n          // Bind the active tab index; Tabs is the header-only control.\n          index: index,\n          children: const [\n            TabItem(child: Text('Tab 1')),\n            TabItem(child: Text('Tab 2')),\n            TabItem(child: Text('Tab 3')),\n          ],\n          onChanged: (int value) {\n            // Keep header and body in sync by updating state.\n            setState(() {\n              index = value;\n            });\n          },\n        ),\n        const Gap(8),\n        // The IndexedStack acts as the tab body; it switches content by index\n        // without unmounting inactive children.\n        IndexedStack(\n          index: index,\n          children: const [\n            NumberedContainer(\n              index: 1,\n            ),\n            NumberedContainer(\n              index: 2,\n            ),\n            NumberedContainer(\n              index: 3,\n            ),\n          ],\n        ).sized(height: 300),\n      ],\n    );\n  }\n}\n",
);

Widget _buildTabsExample1(BuildContext context) {
  return const TabsExample1();
}

const List<ComponentExample> tabsExamples = [
  tabsExample1,
];
