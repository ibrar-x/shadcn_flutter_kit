import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/autocomplete/autocomplete.dart'
    as shadcn_autocomplete;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;

const ComponentExample autocompleteBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildAutocompleteBasicExample,
  code: '''AutoComplete(
  suggestions: ['Apple', 'Banana', 'Cherry'],
  child: TextField(
    placeholder: Text('Search fruit'),
  ),
)''',
);

Widget _buildAutocompleteBasicExample(BuildContext context) {
  const suggestions = [
    'Apple',
    'Apricot',
    'Banana',
    'Blueberry',
    'Cherry',
    'Grape',
    'Orange',
    'Pear',
  ];
  return const shadcn_autocomplete.AutoComplete(
    suggestions: suggestions,
    child: shadcn_text_field.TextField(
      placeholder: Text('Search fruit'),
    ),
  );
}
