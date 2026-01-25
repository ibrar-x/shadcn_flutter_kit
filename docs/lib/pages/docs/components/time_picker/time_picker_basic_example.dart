import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form_field/form_field.dart'
    as shadcn_form_field;
import '../../../../ui/shadcn/components/form/time_picker/time_picker.dart'
    as shadcn_time_picker;
import '../../../../ui/shadcn/shared/utils/util.dart' as shadcn_util;

const ComponentExample timePickerBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildTimePickerBasicExample,
  code: '''TimePicker(
  value: value,
  mode: PromptMode.popover,
  onChanged: (value) => setState(() => value = value ?? TimeOfDay.now()),
)

TimePicker(
  value: value,
  mode: PromptMode.dialog,
  dialogTitle: Text('Select Time'),
  onChanged: (value) => setState(() => value = value ?? TimeOfDay.now()),
)''',
);

Widget _buildTimePickerBasicExample(BuildContext context) {
  return const _TimePickerBasicExample();
}

class _TimePickerBasicExample extends StatefulWidget {
  const _TimePickerBasicExample();

  @override
  State<_TimePickerBasicExample> createState() =>
      _TimePickerBasicExampleState();
}

class _TimePickerBasicExampleState extends State<_TimePickerBasicExample> {
  shadcn_util.TimeOfDay _value = shadcn_util.TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        shadcn_time_picker.TimePicker(
          value: _value,
          mode: shadcn_form_field.PromptMode.popover,
          onChanged: (value) {
            setState(() {
              _value = value ?? shadcn_util.TimeOfDay.now();
            });
          },
        ),
        const Gap(16),
        shadcn_time_picker.TimePicker(
          value: _value,
          mode: shadcn_form_field.PromptMode.dialog,
          dialogTitle: const Text('Select Time'),
          onChanged: (value) {
            setState(() {
              _value = value ?? shadcn_util.TimeOfDay.now();
            });
          },
        ),
      ],
    );
  }
}
