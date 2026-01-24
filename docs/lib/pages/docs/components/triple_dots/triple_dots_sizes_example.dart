import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/triple_dots/triple_dots.dart';
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample tripleDotsSizesExample = ComponentExample(
  title: 'Sizes + spacing',
  builder: _buildTripleDotsSizesExample,
  code: '''MoreDots(size: 4, spacing: 6)''',
);

Widget _buildTripleDotsSizesExample(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Small').xSmall().muted(),
      const SizedBox(height: 6),
      const MoreDots(size: 3, spacing: 4),
      const SizedBox(height: 16),
      const Text('Large').xSmall().muted(),
      const SizedBox(height: 6),
      const MoreDots(size: 6, spacing: 8),
    ],
  );
}
