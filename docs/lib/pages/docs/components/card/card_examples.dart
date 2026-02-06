import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'card_example_1.dart';

const ComponentExample cardExample1 = ComponentExample(
  title: "Card Example",
  builder: _buildCardExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Card with form-like content and actions.\n///\n/// Demonstrates using [Card] as a container with padding, headings,\n/// inputs, and action buttons aligned via a [Row] and [Spacer].\nclass CardExample1 extends StatelessWidget {\n  const CardExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return IntrinsicHeight(\n      child: Card(\n        padding: const EdgeInsets.all(24),\n        child: Column(\n          crossAxisAlignment: CrossAxisAlignment.start,\n          children: [\n            const Text('Create project').semiBold(),\n            const SizedBox(height: 4),\n            const Text('Deploy your new project in one-click').muted().small(),\n            const SizedBox(height: 24),\n            const Text('Name').semiBold().small(),\n            const SizedBox(height: 4),\n            const TextField(placeholder: Text('Name of your project')),\n            const SizedBox(height: 16),\n            const Text('Description').semiBold().small(),\n            const SizedBox(height: 4),\n            const TextField(placeholder: Text('Description of your project')),\n            const SizedBox(height: 24),\n            Row(\n              children: [\n                OutlineButton(\n                  child: const Text('Cancel'),\n                  onPressed: () {},\n                ),\n                const Spacer(),\n                PrimaryButton(\n                  child: const Text('Deploy'),\n                  onPressed: () {},\n                ),\n              ],\n            ),\n          ],\n        ),\n      ),\n    );\n  }\n}\n",
);

Widget _buildCardExample1(BuildContext context) {
  return const CardExample1();
}

const List<ComponentExample> cardExamples = [
  cardExample1,
];
