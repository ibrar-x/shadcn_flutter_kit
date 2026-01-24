import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/autocomplete/autocomplete.dart'
    as shadcn_autocomplete;
import '../../../../ui/shadcn/components/form/chip_input/chip_input.dart'
    as shadcn_chip_input;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample chipInputAutocompleteExample = ComponentExample(
  title: 'With autocomplete',
  builder: _buildChipInputAutocompleteExample,
  code: '''AutoComplete(
  suggestions: ['design', 'docs', 'release'],
  child: ChipInput<String>(
    placeholder: Text('Add labels'),
    onChipSubmitted: (text) => text.isEmpty ? null : text,
    chipBuilder: (context, chip) => Text(chip),
  ),
)''',
);

Widget _buildChipInputAutocompleteExample(BuildContext context) {
  const suggestions = ['design', 'docs', 'release', 'support', 'ui'];
  return shadcn_autocomplete.AutoComplete(
    suggestions: suggestions,
    child: shadcn_chip_input.ChipInput<String>(
      placeholder: const Text('Add labels'),
      onChipSubmitted: (text) => text.isEmpty ? null : text,
      chipBuilder: (context, chip) => Text(chip).xSmall(),
    ),
  );
}
