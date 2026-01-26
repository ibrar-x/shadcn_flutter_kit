import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'toggle_example_1.dart';
import 'toggle_example_2.dart';

const ComponentExample toggleExample1 = ComponentExample(
  title: "Example",
  builder: _buildToggleExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n// Demonstrates a basic boolean Toggle that flips its value when pressed.\n\nclass ToggleExample1 extends StatefulWidget {\n  const ToggleExample1({super.key});\n\n  @override\n  ToggleExample1State createState() => ToggleExample1State();\n}\n\nclass ToggleExample1State extends State<ToggleExample1> {\n  bool value = false;\n\n  @override\n  Widget build(BuildContext context) {\n    return Toggle(\n      // Simple boolean toggle; style/semantics similar to a ToggleButton.\n      value: value,\n      onChanged: (v) {\n        setState(() {\n          value = v;\n        });\n      },\n      child: const Text('Toggle'),\n    );\n  }\n}\n",
);

Widget _buildToggleExample1(BuildContext context) {
  return const ToggleExample1();
}

const ComponentExample toggleExample2 = ComponentExample(
  title: "Group Example",
  builder: _buildToggleExample2,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n// Demonstrates a group of mutually exclusive Toggles (B/I/U) where exactly\n// one formatting option can be active at a time.\n\nclass ToggleExample2 extends StatefulWidget {\n  const ToggleExample2({super.key});\n\n  @override\n  ToggleExample2State createState() => ToggleExample2State();\n}\n\nclass ToggleExample2State extends State<ToggleExample2> {\n  int flag = 0;\n\n  @override\n  Widget build(BuildContext context) {\n    return Row(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        Toggle(\n          // Exactly one of three toggles is active at a time.\n          value: flag == 0,\n          style: const ButtonStyle.outline(density: ButtonDensity.compact),\n          onChanged: (v) {\n            setState(() {\n              // Activate when pressed; deactivate to clear selection.\n              flag = v ? 0 : -1;\n            });\n          },\n          child: const Text('B').bold().center(),\n        ).sized(width: 40, height: 40),\n        Toggle(\n          value: flag == 1,\n          style: const ButtonStyle.outline(density: ButtonDensity.compact),\n          onChanged: (v) {\n            setState(() {\n              flag = v ? 1 : -1;\n            });\n          },\n          child: const Text('I').italic().center(),\n        ).sized(width: 40, height: 40),\n        Toggle(\n          value: flag == 2,\n          style: const ButtonStyle.outline(density: ButtonDensity.compact),\n          onChanged: (v) {\n            setState(() {\n              flag = v ? 2 : -1;\n            });\n          },\n          child: const Text('U').underline().center(),\n        ).sized(width: 40, height: 40),\n      ],\n    ).gap(4);\n  }\n}\n",
);

Widget _buildToggleExample2(BuildContext context) {
  return const ToggleExample2();
}

const List<ComponentExample> toggleExamples = [
  toggleExample1,
  toggleExample2,
];
