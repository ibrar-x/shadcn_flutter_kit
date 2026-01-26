import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'time_picker_example_1.dart';

const ComponentExample timePickerExample1 = ComponentExample(
  title: "Example",
  builder: _buildTimePickerExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n// Demonstrates TimePicker in popover and dialog modes, updating state and\n// handling cancel by falling back to current time.\n\nclass TimePickerExample1 extends StatefulWidget {\n  const TimePickerExample1({super.key});\n\n  @override\n  State<TimePickerExample1> createState() => _TimePickerExample1State();\n}\n\nclass _TimePickerExample1State extends State<TimePickerExample1> {\n  TimeOfDay _value = TimeOfDay.now();\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        TimePicker(\n          value: _value,\n          // Popover mode shows a compact inline picker anchored to the field.\n          mode: PromptMode.popover,\n          onChanged: (value) {\n            setState(() {\n              // If user cancels, keep time by falling back to now.\n              _value = value ?? TimeOfDay.now();\n            });\n          },\n        ),\n        const Gap(16),\n        TimePicker(\n          value: _value,\n          // Dialog mode opens a modal sheet/dialog for selection.\n          mode: PromptMode.dialog,\n          dialogTitle: const Text('Select Time'),\n          onChanged: (value) {\n            setState(() {\n              _value = value ?? TimeOfDay.now();\n            });\n          },\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildTimePickerExample1(BuildContext context) {
  return const TimePickerExample1();
}

const List<ComponentExample> timePickerExamples = [
  timePickerExample1,
];
