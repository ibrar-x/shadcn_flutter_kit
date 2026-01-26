import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'formatted_input_example_1.dart';
import 'formatted_input_example_2.dart';
import 'formatted_input_example_3.dart';
import 'formatted_input_example_4.dart';

const ComponentExample formattedInputExample1 = ComponentExample(
  title: "Formatted Input Example",
  builder: _buildFormattedInputExample1,
  code: "import 'package:flutter/foundation.dart';\nimport 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass FormattedInputExample1 extends StatelessWidget {\n  const FormattedInputExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return FormattedInput(\n      // Demonstrates a date-like formatted input built from editable and static parts.\n      onChanged: (value) {\n        List<String> parts = [];\n        for (FormattedValuePart part in value.values) {\n          parts.add(part.value ?? '');\n        }\n        if (kDebugMode) {\n          print(parts.join('/'));\n        }\n      },\n      initialValue: FormattedValue([\n        const InputPart.editable(length: 2, width: 40, placeholder: Text('MM'))\n            .withValue('01'),\n        const InputPart.static('/'),\n        const InputPart.editable(length: 2, width: 40, placeholder: Text('DD'))\n            .withValue('02'),\n        const InputPart.static('/'),\n        const InputPart.editable(\n                length: 4, width: 60, placeholder: Text('YYYY'))\n            .withValue('2021'),\n      ]),\n    );\n  }\n}\n",
);

Widget _buildFormattedInputExample1(BuildContext context) {
  return const FormattedInputExample1();
}

const ComponentExample formattedInputExample2 = ComponentExample(
  title: "Date Input Example",
  builder: _buildFormattedInputExample2,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass FormattedInputExample2 extends StatefulWidget {\n  const FormattedInputExample2({super.key});\n\n  @override\n  State<FormattedInputExample2> createState() => _FormattedInputExample2State();\n}\n\nclass _FormattedInputExample2State extends State<FormattedInputExample2> {\n  DateTime? _selectedDate;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        DateInput(\n          onChanged: (value) => setState(() => _selectedDate = value),\n        ),\n        const Gap(16),\n        if (_selectedDate != null) Text('Selected date: \$_selectedDate'),\n      ],\n    );\n  }\n}\n",
);

Widget _buildFormattedInputExample2(BuildContext context) {
  return const FormattedInputExample2();
}

const ComponentExample formattedInputExample3 = ComponentExample(
  title: "Time Input Example",
  builder: _buildFormattedInputExample3,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass FormattedInputExample3 extends StatefulWidget {\n  const FormattedInputExample3({super.key});\n\n  @override\n  State<FormattedInputExample3> createState() => _FormattedInputExample3State();\n}\n\nclass _FormattedInputExample3State extends State<FormattedInputExample3> {\n  TimeOfDay? _selected;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        TimeInput(\n          // Built-in formatted control for time-of-day values.\n          onChanged: (value) => setState(() => _selected = value),\n        ),\n        const Gap(16),\n        if (_selected != null) Text('Selected time: \$_selected'),\n      ],\n    );\n  }\n}\n",
);

Widget _buildFormattedInputExample3(BuildContext context) {
  return const FormattedInputExample3();
}

const ComponentExample formattedInputExample4 = ComponentExample(
  title: "Duration Input Example",
  builder: _buildFormattedInputExample4,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass FormattedInputExample4 extends StatefulWidget {\n  const FormattedInputExample4({super.key});\n\n  @override\n  State<FormattedInputExample4> createState() => _FormattedInputExample4State();\n}\n\nclass _FormattedInputExample4State extends State<FormattedInputExample4> {\n  Duration? _selected;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        DurationInput(\n          // Built-in formatted control for durations; shows HH:MM and (optionally) SS.\n          onChanged: (value) => setState(() => _selected = value),\n          showSeconds: true,\n        ),\n        const Gap(16),\n        if (_selected != null) Text('Selected duration: \$_selected'),\n      ],\n    );\n  }\n}\n",
);

Widget _buildFormattedInputExample4(BuildContext context) {
  return const FormattedInputExample4();
}

const List<ComponentExample> formattedInputExamples = [
  formattedInputExample1,
  formattedInputExample2,
  formattedInputExample3,
  formattedInputExample4,
];