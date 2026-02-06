import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'keyboard_display_example_1.dart';

const ComponentExample keyboardDisplayExample1 = ComponentExample(
  title: "Example 1",
  builder: _buildKeyboardDisplayExample1,
  code: "import 'package:flutter/services.dart';\nimport 'package:docs/shadcn_ui.dart';\n\nclass KeyboardDisplayExample1 extends StatelessWidget {\n  const KeyboardDisplayExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    // KeyboardDisplay renders keycaps/shortcuts inline.\n    // Below we show two variants: explicit key list and a SingleActivator.\n    return const Column(\n      children: [\n        KeyboardDisplay(keys: [\n          LogicalKeyboardKey.control,\n          LogicalKeyboardKey.alt,\n          LogicalKeyboardKey.delete,\n        ]),\n        Gap(24),\n        KeyboardDisplay.fromActivator(\n          activator: SingleActivator(\n            LogicalKeyboardKey.keyA,\n            control: true,\n            shift: true,\n          ),\n        )\n      ],\n    ).textSmall();\n  }\n}\n",
);

Widget _buildKeyboardDisplayExample1(BuildContext context) {
  return const KeyboardDisplayExample1();
}

const List<ComponentExample> keyboardDisplayExamples = [
  keyboardDisplayExample1,
];
