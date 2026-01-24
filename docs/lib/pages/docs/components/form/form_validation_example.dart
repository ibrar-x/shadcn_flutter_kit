import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form/form.dart' as shadcn_form;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;

const ComponentExample formValidationExample = ComponentExample(
  title: 'Validation states',
  builder: _buildFormValidationExample,
  code: '''Form(
  child: FormField(
    label: Text('Email'),
    validator: EmailValidator(),
    child: TextField(placeholder: Text('name@acme.com')),
  ),
)''',
);

Widget _buildFormValidationExample(BuildContext context) {
  return const shadcn_form.Form(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        shadcn_form.FormField<String>(
          key: shadcn_form.InputKey(#email),
          label: Text('Email'),
          validator: shadcn_form.EmailValidator(),
          child: shadcn_text_field.TextField(
            placeholder: Text('name@acme.com'),
          ),
        ),
        SizedBox(height: 12),
        shadcn_form.FormField<String>(
          key: shadcn_form.InputKey(#password),
          label: Text('Password'),
          validator: shadcn_form.LengthValidator(min: 6),
          child: shadcn_text_field.TextField(
            placeholder: Text('At least 6 characters'),
            obscureText: true,
          ),
        ),
        SizedBox(height: 16),
        shadcn_form.SubmitButton(
          loading: Text('Validating...'),
          error: Text('Fix errors'),
          child: Text('Create account'),
        ),
      ],
    ),
  );
}
