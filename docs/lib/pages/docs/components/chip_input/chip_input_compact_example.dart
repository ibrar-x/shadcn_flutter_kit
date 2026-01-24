import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/chip/chip.dart' as shadcn_chip;
import '../../../../ui/shadcn/components/form/chip_input/chip_input.dart'
    as shadcn_chip_input;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample chipInputCompactExample = ComponentExample(
  title: 'Compact tokens',
  builder: _buildChipInputCompactExample,
  code: '''ComponentTheme<ChipInputTheme>(
  data: ChipInputTheme(useChips: false),
  child: ChipInput<String>(
    initialChips: ['email', 'push'],
    chipBuilder: (context, chip) => Chip.small(child: Text(chip)),
  ),
)''',
);

Widget _buildChipInputCompactExample(BuildContext context) {
  return shadcn_theme.ComponentTheme<shadcn_chip_input.ChipInputTheme>(
    data: const shadcn_chip_input.ChipInputTheme(useChips: false),
    child: shadcn_chip_input.ChipInput<String>(
      initialChips: const ['email', 'push'],
      placeholder: const Text('Channels'),
      onChipSubmitted: (text) => text.isEmpty ? null : text,
      chipBuilder: (context, chip) => shadcn_chip.Chip(
        child: Text(chip),
      ),
    ),
  );
}
