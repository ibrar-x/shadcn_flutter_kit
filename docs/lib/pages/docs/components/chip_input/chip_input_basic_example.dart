import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/chip_input/chip_input.dart'
    as shadcn_chip_input;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample chipInputBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildChipInputBasicExample,
  code: '''ChipInput<String>(
  initialChips: ['design', 'docs'],
  placeholder: Text('Add tags'),
  onChipSubmitted: (text) => text.isEmpty ? null : text,
  chipBuilder: (context, chip) => Text(chip),
)''',
);

Widget _buildChipInputBasicExample(BuildContext context) {
  return shadcn_chip_input.ChipInput<String>(
    initialChips: const ['design', 'docs'],
    placeholder: const Text('Add tags'),
    onChipSubmitted: (text) => text.isEmpty ? null : text,
    chipBuilder: (context, chip) => Text(chip).small(),
  );
}
