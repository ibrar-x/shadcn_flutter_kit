import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'chip_example_1.dart';

const ComponentExample chipExample1 = ComponentExample(
  title: "Example",
  builder: _buildChipExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Chips with trailing remove buttons in different styles.\n///\n/// Demonstrates how to compose [Chip] with a [ChipButton] trailing action,\n/// and how to apply various [ButtonStyle] presets.\nclass ChipExample1 extends StatelessWidget {\n  const ChipExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Wrap(\n      spacing: 8,\n      runSpacing: 8,\n      children: [\n        Chip(\n          // Trailing action; in real apps you might remove the chip.\n          trailing: ChipButton(\n            onPressed: () {},\n            child: const Icon(Icons.close),\n          ),\n          child: const Text('Apple'),\n        ),\n        Chip(\n          // Primary-styled chip.\n          style: const ButtonStyle.primary(),\n          trailing: ChipButton(\n            onPressed: () {},\n            child: const Icon(Icons.close),\n          ),\n          child: const Text('Banana'),\n        ),\n        Chip(\n          // Outlined chip.\n          style: const ButtonStyle.outline(),\n          trailing: ChipButton(\n            onPressed: () {},\n            child: const Icon(Icons.close),\n          ),\n          child: const Text('Cherry'),\n        ),\n        Chip(\n          // Ghost chip (very subtle background).\n          style: const ButtonStyle.ghost(),\n          trailing: ChipButton(\n            onPressed: () {},\n            child: const Icon(Icons.close),\n          ),\n          child: const Text('Durian'),\n        ),\n        Chip(\n          // Destructive-styled chip for warning/critical labels.\n          style: const ButtonStyle.destructive(),\n          trailing: ChipButton(\n            onPressed: () {},\n            child: const Icon(Icons.close),\n          ),\n          child: const Text('Elderberry'),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildChipExample1(BuildContext context) {
  return const ChipExample1();
}

const List<ComponentExample> chipExamples = [
  chipExample1,
];
