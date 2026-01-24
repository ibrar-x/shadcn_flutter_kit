import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form/form.dart' as shadcn_form;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;

const ComponentExample formBasicExample = ComponentExample(
  title: 'Basic form',
  builder: _buildFormBasicExample,
  code: '''Form(
  child: Column(
    children: [
      FormField(
        label: Text('Name'),
        validator: NotEmptyValidator(),
        child: TextField(placeholder: Text('Your name')),
      ),
      SubmitButton(child: Text('Save')),
    ],
  ),
)''',
);

Widget _buildFormBasicExample(BuildContext context) {
  return const shadcn_form.Form(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        shadcn_form.FormField<String>(
          key: shadcn_form.InputKey(#name),
          label: Text('Name'),
          validator: shadcn_form.NotEmptyValidator(),
          child: shadcn_text_field.TextField(
            placeholder: Text('Your name'),
          ),
        ),
        SizedBox(height: 16),
        shadcn_form.SubmitButton(
          child: Text('Save'),
        ),
      ],
    ),
  );
}
