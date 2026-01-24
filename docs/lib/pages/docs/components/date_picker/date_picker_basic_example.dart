import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/date_picker/date_picker.dart'
    as shadcn_date_picker;

const ComponentExample datePickerBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildDatePickerBasicExample,
  code: '''DatePicker(
  value: DateTime.now(),
  onChanged: (value) {},
)''',
);

Widget _buildDatePickerBasicExample(BuildContext context) {
  return const _DatePickerBasicExample();
}

class _DatePickerBasicExample extends StatefulWidget {
  const _DatePickerBasicExample();

  @override
  State<_DatePickerBasicExample> createState() =>
      _DatePickerBasicExampleState();
}

class _DatePickerBasicExampleState extends State<_DatePickerBasicExample> {
  DateTime? _value = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return shadcn_date_picker.DatePicker(
      value: _value,
      onChanged: (value) => setState(() => _value = value),
    );
  }
}
