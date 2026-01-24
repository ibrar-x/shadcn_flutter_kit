import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form_field/form_field.dart'
    as shadcn_form_field;
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;

const ComponentExample formFieldPopoverExample = ComponentExample(
  title: 'Popover picker',
  builder: _buildFormFieldPopoverExample,
  code: '''ObjectFormField<String>(
  value: value,
  mode: PromptMode.popover,
  immediateValueChange: true,
  editorBuilder: (context, handler) => ...,
)''',
);

Widget _buildFormFieldPopoverExample(BuildContext context) {
  return const _FormFieldPopoverExample();
}

class _FormFieldPopoverExample extends StatefulWidget {
  const _FormFieldPopoverExample();

  @override
  State<_FormFieldPopoverExample> createState() =>
      _FormFieldPopoverExampleState();
}

class _FormFieldPopoverExampleState extends State<_FormFieldPopoverExample> {
  String? _value = 'Low';

  @override
  Widget build(BuildContext context) {
    return shadcn_form_field.ObjectFormField<String>(
      value: _value,
      placeholder: const Text('Priority'),
      mode: shadcn_form_field.PromptMode.popover,
      immediateValueChange: true,
      builder: (context, value) => Text(value),
      editorBuilder: (context, handler) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            shadcn_buttons.GhostButton(
              onPressed: () => handler.value = 'Low',
              child: const Text('Low'),
            ),
            shadcn_buttons.GhostButton(
              onPressed: () => handler.value = 'Medium',
              child: const Text('Medium'),
            ),
            shadcn_buttons.GhostButton(
              onPressed: () => handler.value = 'High',
              child: const Text('High'),
            ),
          ],
        );
      },
      onChanged: (value) => setState(() => _value = value),
    );
  }
}
