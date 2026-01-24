import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/calendar/calendar.dart'
    as shadcn_calendar;
import '../../../../ui/shadcn/components/form/date_picker/date_picker.dart'
    as shadcn_date_picker;
import '../../../../ui/shadcn/components/form/form_field/form_field.dart'
    as shadcn_form_field;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample datePickerPopoverExample = ComponentExample(
  title: 'Popover month view',
  builder: _buildDatePickerPopoverExample,
  code: '''ComponentTheme<DatePickerTheme>(
  data: DatePickerTheme(mode: PromptMode.popover),
  child: DatePicker(
    value: value,
    initialViewType: CalendarViewType.month,
  ),
)''',
);

Widget _buildDatePickerPopoverExample(BuildContext context) {
  return const _DatePickerPopoverExample();
}

class _DatePickerPopoverExample extends StatefulWidget {
  const _DatePickerPopoverExample();

  @override
  State<_DatePickerPopoverExample> createState() =>
      _DatePickerPopoverExampleState();
}

class _DatePickerPopoverExampleState extends State<_DatePickerPopoverExample> {
  DateTime? _value = DateTime.now();

  @override
  Widget build(BuildContext context) {
  return shadcn_theme.ComponentTheme<shadcn_date_picker.DatePickerTheme>(
    data: const shadcn_date_picker.DatePickerTheme(
      mode: shadcn_form_field.PromptMode.popover,
    ),
      child: shadcn_date_picker.DatePicker(
        value: _value,
        initialViewType: shadcn_calendar.CalendarViewType.month,
        onChanged: (value) => setState(() => _value = value),
      ),
    );
  }
}
