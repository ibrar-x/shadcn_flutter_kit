import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/calendar/calendar.dart'
    as shadcn_calendar;
import '../../../../ui/shadcn/components/form/date_picker/date_picker.dart'
    as shadcn_date_picker;

const ComponentExample datePickerDisabledExample = ComponentExample(
  title: 'Disable past dates',
  builder: _buildDatePickerDisabledExample,
  code: '''DatePicker(
  value: value,
  stateBuilder: (date) => date.isBefore(DateTime.now())
      ? DateState.disabled
      : DateState.enabled,
)''',
);

Widget _buildDatePickerDisabledExample(BuildContext context) {
  return const _DatePickerDisabledExample();
}

class _DatePickerDisabledExample extends StatefulWidget {
  const _DatePickerDisabledExample();

  @override
  State<_DatePickerDisabledExample> createState() =>
      _DatePickerDisabledExampleState();
}

class _DatePickerDisabledExampleState
    extends State<_DatePickerDisabledExample> {
  DateTime? _value = DateTime.now().add(const Duration(days: 2));

  @override
  Widget build(BuildContext context) {
    return shadcn_date_picker.DatePicker(
      value: _value,
      onChanged: (value) => setState(() => _value = value),
      stateBuilder: (date) {
        final today = DateTime.now();
        final trimmed = DateTime(today.year, today.month, today.day);
        return date.isBefore(trimmed)
            ? shadcn_calendar.DateState.disabled
            : shadcn_calendar.DateState.enabled;
      },
    );
  }
}
