import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'divider_example_1.dart';
import 'divider_example_2.dart';
import 'divider_example_3.dart';

const ComponentExample dividerExample1 = ComponentExample(
  title: "Horizontal Divider Example",
  builder: _buildDividerExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Horizontal dividers between list items.\n///\n/// Use [Divider] to visually separate vertically-stacked content.\nclass DividerExample1 extends StatelessWidget {\n  const DividerExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const SizedBox(\n      width: 300,\n      child: Column(\n        crossAxisAlignment: CrossAxisAlignment.stretch,\n        children: [\n          Text('Item 1'),\n          Divider(),\n          Text('Item 2'),\n          Divider(),\n          Text('Item 3'),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildDividerExample1(BuildContext context) {
  return const DividerExample1();
}

const ComponentExample dividerExample2 = ComponentExample(
  title: "Vertical Divider Example",
  builder: _buildDividerExample2,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Vertical dividers between columns.\n///\n/// Use [VerticalDivider] to separate horizontally-arranged content.\nclass DividerExample2 extends StatelessWidget {\n  const DividerExample2({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const SizedBox(\n      width: 300,\n      height: 100,\n      child: Row(\n        crossAxisAlignment: CrossAxisAlignment.stretch,\n        children: [\n          Expanded(child: Text('Item 1')),\n          VerticalDivider(),\n          Expanded(child: Text('Item 2')),\n          VerticalDivider(),\n          Expanded(child: Text('Item 3')),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildDividerExample2(BuildContext context) {
  return const DividerExample2();
}

const ComponentExample dividerExample3 = ComponentExample(
  title: "Divider with Text Example",
  builder: _buildDividerExample3,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Dividers with centered labels.\n///\n/// [Divider.child] can render text or other widgets inline with the rule.\nclass DividerExample3 extends StatelessWidget {\n  const DividerExample3({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const SizedBox(\n      width: 300,\n      child: Column(\n        crossAxisAlignment: CrossAxisAlignment.stretch,\n        children: [\n          Text('Item 1'),\n          Divider(\n            child: Text('Divider'),\n          ),\n          Text('Item 2'),\n          Divider(\n            child: Text('Divider'),\n          ),\n          Text('Item 3'),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildDividerExample3(BuildContext context) {
  return const DividerExample3();
}

const List<ComponentExample> dividerExamples = [
  dividerExample1,
  dividerExample2,
  dividerExample3,
];
