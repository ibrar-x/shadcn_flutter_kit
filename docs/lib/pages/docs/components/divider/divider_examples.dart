import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'divider_example_1.dart';
import 'divider_example_2.dart';
import 'divider_example_3.dart';
import 'divider_example_4.dart';

const ComponentExample dividerExample1 = ComponentExample(
  title: "Horizontal Divider Example",
  builder: _buildDividerExample1,
  code:
      "import 'package:docs/shadcn_ui.dart';\n\n/// Horizontal dividers between list items.\n///\n/// Use [Divider] to visually separate vertically-stacked content.\nclass DividerExample1 extends StatelessWidget {\n  const DividerExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const SizedBox(\n      width: 300,\n      child: Column(\n        crossAxisAlignment: CrossAxisAlignment.stretch,\n        children: [\n          Text('Item 1'),\n          Divider(),\n          Text('Item 2'),\n          Divider(),\n          Text('Item 3'),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildDividerExample1(BuildContext context) {
  return const DividerExample1();
}

const ComponentExample dividerExample2 = ComponentExample(
  title: "Vertical Divider Example",
  builder: _buildDividerExample2,
  code:
      "import 'package:docs/shadcn_ui.dart';\n\n/// Vertical dividers between columns.\n///\n/// Use [VerticalDivider] to separate horizontally-arranged content.\nclass DividerExample2 extends StatelessWidget {\n  const DividerExample2({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const SizedBox(\n      width: 300,\n      height: 100,\n      child: Row(\n        crossAxisAlignment: CrossAxisAlignment.stretch,\n        children: [\n          Expanded(child: Text('Item 1')),\n          VerticalDivider(),\n          Expanded(child: Text('Item 2')),\n          VerticalDivider(),\n          Expanded(child: Text('Item 3')),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildDividerExample2(BuildContext context) {
  return const DividerExample2();
}

const ComponentExample dividerExample3 = ComponentExample(
  title: "Divider with Text Example",
  builder: _buildDividerExample3,
  code:
      "import 'package:docs/shadcn_ui.dart';\n\n/// Dividers with centered labels.\n///\n/// [Divider.child] can render text or other widgets inline with the rule.\nclass DividerExample3 extends StatelessWidget {\n  const DividerExample3({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const SizedBox(\n      width: 300,\n      child: Column(\n        crossAxisAlignment: CrossAxisAlignment.stretch,\n        children: [\n          Text('Item 1'),\n          Divider(\n            child: Text('Divider'),\n          ),\n          Text('Item 2'),\n          Divider(\n            child: Text('Divider'),\n          ),\n          Text('Item 3'),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildDividerExample3(BuildContext context) {
  return const DividerExample3();
}

const ComponentExample dividerExample4 = ComponentExample(
  title: "Divider Splitter Example",
  builder: _buildDividerExample4,
  code:
      "import 'package:docs/shadcn_ui.dart';\nimport 'package:docs/ui/shadcn/components/layout/flex/flex.dart' show PaintOrder;\n\n/// Divider splitter-style example with interactive center control.\nclass DividerExample4 extends StatelessWidget {\n  const DividerExample4({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return OutlinedContainer(\n      width: 600,\n      height: 400,\n      child: Row(\n        crossAxisAlignment: CrossAxisAlignment.stretch,\n        children: [\n          Container(\n            color: Theme.of(context).colorScheme.border.withAlpha(64),\n            width: 100,\n            child: ListView.builder(\n              itemCount: 50,\n              itemBuilder: (context, index) {\n                return Button.ghost(\n                  onPressed: () {},\n                  child: Text('Button \$index'),\n                );\n              },\n            ),\n          ),\n          PaintOrder(\n            paintOrder: 3,\n            child: VerticalDivider(\n              childAlignment: const AxisAlignment(-0.6),\n              padding: EdgeInsets.zero,\n              child: IconButton.outline(\n                icon: const Icon(Icons.arrow_back_ios_new),\n                shape: ButtonShape.circle,\n                size: ButtonSize.small,\n                onPressed: () {},\n              ),\n            ),\n          ),\n          const Expanded(\n            child: ColoredBox(\n              color: Colors.black,\n            ),\n          ),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildDividerExample4(BuildContext context) {
  return const DividerExample4();
}

const List<ComponentExample> dividerExamples = [
  dividerExample1,
  dividerExample2,
  dividerExample3,
  dividerExample4,
];
