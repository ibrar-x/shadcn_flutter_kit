import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'linear_progress_example_1.dart';
import 'linear_progress_example_2.dart';

const ComponentExample linearProgressExample1 = ComponentExample(
  title: "Indeterminate Example",
  builder: _buildLinearProgressExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass LinearProgressExample1 extends StatelessWidget {\n  const LinearProgressExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    // Indeterminate linear progress indicator with a fixed width.\n    // When no `value` is provided, it displays an animated looping bar.\n    return const SizedBox(\n      width: 200,\n      child: LinearProgressIndicator(),\n    );\n  }\n}\n",
);

Widget _buildLinearProgressExample1(BuildContext context) {
  return const LinearProgressExample1();
}

const ComponentExample linearProgressExample2 = ComponentExample(
  title: "Determinate Example",
  builder: _buildLinearProgressExample2,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass LinearProgressExample2 extends StatefulWidget {\n  const LinearProgressExample2({super.key});\n\n  @override\n  State<LinearProgressExample2> createState() => _LinearProgressExample2State();\n}\n\nclass _LinearProgressExample2State extends State<LinearProgressExample2> {\n  double value = 0;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        SizedBox(\n          width: 200,\n          child: LinearProgressIndicator(\n            // Supplying a value (0.0..1.0) switches the indicator to determinate mode.\n            value: value,\n          ),\n        ),\n        const Gap(24),\n        Row(\n          mainAxisSize: MainAxisSize.min,\n          children: [\n            PrimaryButton(\n              onPressed: () {\n                setState(() {\n                  value = 0;\n                });\n              },\n              child: const Text('Reset'),\n            ),\n            const Gap(24),\n            PrimaryButton(\n              onPressed: () {\n                if (value + 0.1 >= 1) {\n                  return;\n                }\n                setState(() {\n                  value += 0.1;\n                });\n              },\n              child: const Text('Increase'),\n            ),\n            const Gap(24),\n            PrimaryButton(\n              onPressed: () {\n                if (value - 0.1 <= 0) {\n                  return;\n                }\n                setState(() {\n                  value -= 0.1;\n                });\n              },\n              child: const Text('Decrease'),\n            ),\n          ],\n        )\n      ],\n    );\n  }\n}\n",
);

Widget _buildLinearProgressExample2(BuildContext context) {
  return const LinearProgressExample2();
}

const List<ComponentExample> linearProgressExamples = [
  linearProgressExample1,
  linearProgressExample2,
];
