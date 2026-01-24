import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form_field/form_field.dart'
    as shadcn_form_field;
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;

const ComponentExample formFieldActionsExample = ComponentExample(
  title: 'Dialog actions',
  builder: _buildFormFieldActionsExample,
  code: '''ObjectFormField<String>(
  dialogActions: (context, handler) => [
    OutlineButton(child: Text('Cancel')),
    PrimaryButton(child: Text('Save')),
  ],
)''',
);

Widget _buildFormFieldActionsExample(BuildContext context) {
  return const _FormFieldActionsExample();
}

class _FormFieldActionsExample extends StatefulWidget {
  const _FormFieldActionsExample();

  @override
  State<_FormFieldActionsExample> createState() =>
      _FormFieldActionsExampleState();
}

class _FormFieldActionsExampleState extends State<_FormFieldActionsExample> {
  String? _value = 'Weekly';

  @override
  Widget build(BuildContext context) {
    return shadcn_form_field.ObjectFormField<String>(
      value: _value,
      placeholder: const Text('Schedule'),
      builder: (context, value) => Text(value),
      dialogActions: (context, handler) => [
        shadcn_buttons.OutlineButton(
          onPressed: () => handler.close(),
          child: const Text('Cancel'),
        ),
        shadcn_buttons.PrimaryButton(
          onPressed: () => handler.close(),
          child: const Text('Save'),
        ),
      ],
      editorBuilder: (context, handler) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            shadcn_buttons.GhostButton(
              onPressed: () => handler.value = 'Daily',
              child: const Text('Daily'),
            ),
            shadcn_buttons.GhostButton(
              onPressed: () => handler.value = 'Weekly',
              child: const Text('Weekly'),
            ),
            shadcn_buttons.GhostButton(
              onPressed: () => handler.value = 'Monthly',
              child: const Text('Monthly'),
            ),
          ],
        );
      },
      onChanged: (value) => setState(() => _value = value),
    );
  }
}
