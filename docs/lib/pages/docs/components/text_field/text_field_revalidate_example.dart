import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form/form.dart' as shadcn_form;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;

const ComponentExample textFieldRevalidateExample = ComponentExample(
  title: 'Revalidate',
  builder: _buildTextFieldRevalidateExample,
  code: '''Form(
  child: FormField(
    key: InputKey(#test),
    label: Text('Username'),
    validator: ConditionalValidator((value) async {
      await Future.delayed(Duration(seconds: 1));
      return !['M Ibrar', 'septogeddon', 'admin'].contains(value);
    }, message: 'Username already taken'),
    child: TextField(
      placeholder: Text('Enter your username'),
      initialValue: 'M Ibrar',
      features: [InputFeature.revalidate()],
    ),
  ),
)''',
);

Widget _buildTextFieldRevalidateExample(BuildContext context) {
  return const shadcn_form.Form(
    child: shadcn_form.FormField<String>(
      key: shadcn_form.InputKey(#test),
      label: Text('Username'),
      validator: shadcn_form.ConditionalValidator(
        _TextFieldRevalidateExample._checkUsername,
        message: 'Username already taken',
      ),
      child: shadcn_text_field.TextField(
        placeholder: Text('Enter your username'),
        initialValue: 'M Ibrar',
        features: [
          shadcn_text_field.InputFeature.revalidate(),
        ],
      ),
    ),
  );
}

class _TextFieldRevalidateExample {
  static Future<bool> _checkUsername(String? value) async {
    await Future.delayed(const Duration(seconds: 1));
    if (value == null || value.isEmpty) {
      return true;
    }
    return !['M Ibrar', 'septogeddon', 'admin'].contains(value);
  }
}
