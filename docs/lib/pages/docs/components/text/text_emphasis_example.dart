import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/text/text.dart';

const ComponentExample textEmphasisExample = ComponentExample(
  title: 'Emphasis + monospace',
  builder: _buildTextEmphasisExample,
  code: '''Column(
  children: [
    Text('Muted helper text').small().muted(),
    Text('Semibold label').semiBold(),
    Text('Mono 12px').mono.small(),
  ],
)''',
);

Widget _buildTextEmphasisExample(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Muted helper text').small().muted(),
      const SizedBox(height: 6),
      const Text('Semibold label').semiBold(),
      const SizedBox(height: 6),
      const Text('Mono 12px').mono.small(),
    ],
  );
}
