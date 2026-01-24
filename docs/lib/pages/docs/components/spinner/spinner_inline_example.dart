import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/shared/primitives/text.dart';
import 'spinner_shared.dart';

const ComponentExample spinnerInlineExample = ComponentExample(
  title: 'Inline loading',
  builder: _buildSpinnerInlineExample,
  code: '''Row(
  children: [
    CircleSpinner(size: 16),
    SizedBox(width: 8),
    Text('Syncing...'),
  ],
)''',
);

Widget _buildSpinnerInlineExample(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const CircleSpinner(size: 16),
      const SizedBox(width: 8),
      const Text('Syncing...').small().muted(),
    ],
  );
}
