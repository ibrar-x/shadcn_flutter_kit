import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/autocomplete/autocomplete.dart'
    as shadcn_autocomplete;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample autocompleteCustomCompleteExample = ComponentExample(
  title: 'Custom completer',
  builder: _buildAutocompleteCustomCompleteExample,
  code: '''ComponentTheme<AutoCompleteTheme>(
  data: AutoCompleteTheme(popoverConstraints: BoxConstraints(maxHeight: 160)),
  child: AutoComplete(
    suggestions: ['docs', 'theme', 'components'],
    completer: (value) => '#'+ value,
    child: TextField(
      placeholder: Text('Type a tag'),
    ),
  ),
)''',
);

Widget _buildAutocompleteCustomCompleteExample(BuildContext context) {
  const suggestions = ['docs', 'theme', 'components', 'registry', 'shadcn'];
  return shadcn_theme.ComponentTheme<shadcn_autocomplete.AutoCompleteTheme>(
    data: const shadcn_autocomplete.AutoCompleteTheme(
      popoverConstraints: BoxConstraints(maxHeight: 160),
    ),
    child: shadcn_autocomplete.AutoComplete(
      suggestions: suggestions,
      completer: (value) => '#$value',
      child: const shadcn_text_field.TextField(
        placeholder: Text('Type a tag'),
      ),
    ),
  );
}
