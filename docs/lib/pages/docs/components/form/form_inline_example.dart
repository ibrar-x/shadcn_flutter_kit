import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form/form.dart' as shadcn_form;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;

const ComponentExample formInlineExample = ComponentExample(
  title: 'Inline layout',
  builder: _buildFormInlineExample,
  code: '''Form(
  child: FormInline(
    key: InputKey(#city),
    label: Text('City'),
    child: TextField(placeholder: Text('San Francisco')),
  ),
)''',
);

Widget _buildFormInlineExample(BuildContext context) {
  return const shadcn_form.Form(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        shadcn_form.FormInline<String>(
          key: shadcn_form.InputKey(#city),
          label: Text('City'),
          child: shadcn_text_field.TextField(
            placeholder: Text('San Francisco'),
          ),
        ),
        SizedBox(height: 12),
        shadcn_form.FormInline<String>(
          key: shadcn_form.InputKey(#team),
          label: Text('Team'),
          hint: Text('Keep it short'),
          validator: shadcn_form.NotEmptyValidator(),
          child: shadcn_text_field.TextField(
            placeholder: Text('Design'),
          ),
        ),
      ],
    ),
  );
}
