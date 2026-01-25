import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/radio_group/radio_group.dart'
    as shadcn_radio_group;

const ComponentExample radioGroupBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildRadioGroupBasicExample,
  code: r'''RadioGroup<int>(
  value: selectedValue,
  onChanged: (value) {
    setState(() => selectedValue = value);
  },
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RadioItem(value: 1, trailing: Text('Option 1')),
      RadioItem(value: 2, trailing: Text('Option 2')),
      RadioItem(value: 3, trailing: Text('Option 3')),
    ],
  ),
)
Text('Selected: $selectedValue')''',
);

Widget _buildRadioGroupBasicExample(BuildContext context) {
  return const _RadioGroupBasicExample();
}

class _RadioGroupBasicExample extends StatefulWidget {
  const _RadioGroupBasicExample();

  @override
  State<_RadioGroupBasicExample> createState() =>
      _RadioGroupBasicExampleState();
}

class _RadioGroupBasicExampleState extends State<_RadioGroupBasicExample> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shadcn_radio_group.RadioGroup<int>(
          value: _selectedValue,
          onChanged: (value) {
            setState(() => _selectedValue = value);
          },
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shadcn_radio_group.RadioItem(
                value: 1,
                trailing: Text('Option 1'),
              ),
              shadcn_radio_group.RadioItem(
                value: 2,
                trailing: Text('Option 2'),
              ),
              shadcn_radio_group.RadioItem(
                value: 3,
                trailing: Text('Option 3'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Selected: $_selectedValue'),
      ],
    );
  }
}
