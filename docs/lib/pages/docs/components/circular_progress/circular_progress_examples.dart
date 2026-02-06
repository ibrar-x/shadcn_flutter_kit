import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'circular_progress_example_1.dart';
import 'circular_progress_example_2.dart';

const ComponentExample circularProgressExample1 = ComponentExample(
  title: "Circular Progress Example",
  builder: _buildCircularProgressExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Indeterminate circular progress indicator.\n///\n/// Use when progress amount is unknown and you want to indicate activity.\nclass CircularProgressExample1 extends StatelessWidget {\n  const CircularProgressExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const CircularProgressIndicator();\n  }\n}\n",
);

Widget _buildCircularProgressExample1(BuildContext context) {
  return const CircularProgressExample1();
}

const ComponentExample circularProgressExample2 = ComponentExample(
  title: "Circular Progress with Value Example",
  builder: _buildCircularProgressExample2,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Determinate circular progress indicator with controls.\n///\n/// Demonstrates binding a numeric progress value to [CircularProgressIndicator]\n/// and updating it via buttons. Value should be a fraction between 0 and 1.\nclass CircularProgressExample2 extends StatefulWidget {\n  const CircularProgressExample2({super.key});\n\n  @override\n  State<CircularProgressExample2> createState() =>\n      _CircularProgressExample2State();\n}\n\nclass _CircularProgressExample2State extends State<CircularProgressExample2> {\n  // Track progress in percentage (0-100) for easier mental mapping.\n  double _progress = 0;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        CircularProgressIndicator(\n          // The widget expects a normalized value [0..1].\n          value: _progress.clamp(0, 100) / 100,\n          size: 48,\n        ),\n        const Gap(48),\n        Row(\n          children: [\n            DestructiveButton(\n              onPressed: () {\n                setState(() {\n                  // Reset to 0%.\n                  _progress = 0;\n                });\n              },\n              child: const Text('Reset'),\n            ),\n            const Gap(16),\n            PrimaryButton(\n              onPressed: () {\n                setState(() {\n                  // Decrease by 10%.\n                  _progress -= 10;\n                });\n              },\n              child: const Text('Decrease by 10'),\n            ),\n            const Gap(16),\n            PrimaryButton(\n              onPressed: () {\n                setState(() {\n                  // Increase by 10%.\n                  _progress += 10;\n                });\n              },\n              child: const Text('Increase by 10'),\n            ),\n          ],\n        )\n      ],\n    );\n  }\n}\n",
);

Widget _buildCircularProgressExample2(BuildContext context) {
  return const CircularProgressExample2();
}

const List<ComponentExample> circularProgressExamples = [
  circularProgressExample1,
  circularProgressExample2,
];
