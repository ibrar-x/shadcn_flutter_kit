import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'date_picker_example_1.dart';
import 'date_picker_example_2.dart';

const ComponentExample datePickerExample1 = ComponentExample(
  title: "Date Picker Example",
  builder: _buildDatePickerExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// DatePicker in popover and dialog modes with disabled future dates.\n///\n/// Demonstrates single-date selection with two different prompt UIs:\n/// - [PromptMode.popover]: inline, anchored overlay.\n/// - [PromptMode.dialog]: modal dialog with a custom [dialogTitle].\nclass DatePickerExample1 extends StatefulWidget {\n  const DatePickerExample1({super.key});\n\n  @override\n  State<DatePickerExample1> createState() => _DatePickerExample1State();\n}\n\nclass _DatePickerExample1State extends State<DatePickerExample1> {\n  DateTime? _value;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        DatePicker(\n          value: _value,\n          mode: PromptMode.popover,\n          // Disable selecting dates after \"today\".\n          stateBuilder: (date) {\n            if (date.isAfter(DateTime.now())) {\n              return DateState.disabled;\n            }\n            return DateState.enabled;\n          },\n          onChanged: (value) {\n            setState(() {\n              _value = value;\n            });\n          },\n        ),\n        const Gap(16),\n        DatePicker(\n          value: _value,\n          mode: PromptMode.dialog,\n          // Title shown at the top of the dialog variant.\n          dialogTitle: const Text('Select Date'),\n          stateBuilder: (date) {\n            if (date.isAfter(DateTime.now())) {\n              return DateState.disabled;\n            }\n            return DateState.enabled;\n          },\n          onChanged: (value) {\n            setState(() {\n              _value = value;\n            });\n          },\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildDatePickerExample1(BuildContext context) {
  return const DatePickerExample1();
}

const ComponentExample datePickerExample2 = ComponentExample(
  title: "Date Range Picker Example",
  builder: _buildDatePickerExample2,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// DateRangePicker in popover and dialog modes.\n///\n/// Similar to the single-date picker, but selects a [DateTimeRange].\nclass DatePickerExample2 extends StatefulWidget {\n  const DatePickerExample2({super.key});\n\n  @override\n  State<DatePickerExample2> createState() => _DatePickerExample2State();\n}\n\nclass _DatePickerExample2State extends State<DatePickerExample2> {\n  DateTimeRange? _value;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        DateRangePicker(\n          value: _value,\n          mode: PromptMode.popover,\n          onChanged: (value) {\n            setState(() {\n              _value = value;\n            });\n          },\n        ),\n        const Gap(16),\n        DateRangePicker(\n          value: _value,\n          mode: PromptMode.dialog,\n          // Title for the dialog variant.\n          dialogTitle: const Text('Select Date Range'),\n          onChanged: (value) {\n            setState(() {\n              _value = value;\n            });\n          },\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildDatePickerExample2(BuildContext context) {
  return const DatePickerExample2();
}

const List<ComponentExample> datePickerExamples = [
  datePickerExample1,
  datePickerExample2,
];
