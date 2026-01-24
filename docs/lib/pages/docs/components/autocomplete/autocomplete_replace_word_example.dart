import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/autocomplete/autocomplete.dart'
    as shadcn_autocomplete;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;

const ComponentExample autocompleteReplaceWordExample = ComponentExample(
  title: 'Replace word',
  builder: _buildAutocompleteReplaceWordExample,
  code: '''AutoComplete(
  suggestions: ['shadcn', 'flutter', 'registry'],
  mode: AutoCompleteMode.replaceWord,
  child: TextField(
    placeholder: Text('Try typing: sh'),
  ),
)''',
);

Widget _buildAutocompleteReplaceWordExample(BuildContext context) {
  const suggestions = ['shadcn', 'flutter', 'registry', 'component', 'docs'];
  return const shadcn_autocomplete.AutoComplete(
    suggestions: suggestions,
    mode: shadcn_autocomplete.AutoCompleteMode.replaceWord,
    child: shadcn_text_field.TextField(
      placeholder: Text('Try typing: sh'),
    ),
  );
}
