import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'radio_group_example_1.dart';

const ComponentExample radioGroupExample1 = ComponentExample(
  title: "Example",
  builder: _buildRadioGroupExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass RadioGroupExample1 extends StatefulWidget {\n  const RadioGroupExample1({super.key});\n\n  @override\n  State<RadioGroupExample1> createState() => _RadioGroupExample1State();\n}\n\nclass _RadioGroupExample1State extends State<RadioGroupExample1> {\n  // Start with no selection (null). The UI reflects this until the user picks an option.\n  int? selectedValue;\n\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      crossAxisAlignment: CrossAxisAlignment.start,\n      children: [\n        // A generic RadioGroup for int values. It controls selection for its RadioItem children.\n        RadioGroup<int>(\n          value: selectedValue,\n          onChanged: (value) {\n            setState(() {\n              // Save the selected value emitted by the tapped RadioItem.\n              selectedValue = value;\n            });\n          },\n          child: const Column(\n            crossAxisAlignment: CrossAxisAlignment.start,\n            children: [\n              // Each RadioItem represents a single choice with an associated integer value.\n              RadioItem(\n                value: 1,\n                trailing: Text('Option 1'),\n              ),\n              RadioItem(\n                value: 2,\n                trailing: Text('Option 2'),\n              ),\n              RadioItem(\n                value: 3,\n                trailing: Text('Option 3'),\n              ),\n            ],\n          ),\n        ),\n        const Gap(16),\n        // Echo the selection below for demonstration purposes.\n        Text('Selected: \$selectedValue'),\n      ],\n    );\n  }\n}\n",
);

Widget _buildRadioGroupExample1(BuildContext context) {
  return const RadioGroupExample1();
}

const List<ComponentExample> radioGroupExamples = [
  radioGroupExample1,
];