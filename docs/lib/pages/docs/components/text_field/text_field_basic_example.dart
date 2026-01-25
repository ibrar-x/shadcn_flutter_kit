import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;

const ComponentExample textFieldBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildTextFieldBasicExample,
  code: '''TextField(
  placeholder: Text('Enter your name'),
)''',
);

Widget _buildTextFieldBasicExample(BuildContext context) {
  return const shadcn_text_field.TextField(
    placeholder: Text('Enter your name'),
  );
}
