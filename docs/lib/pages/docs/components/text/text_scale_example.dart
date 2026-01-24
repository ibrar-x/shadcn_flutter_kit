import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/text/text.dart';

const ComponentExample textScaleExample = ComponentExample(
  title: 'Type scale',
  builder: _buildTextScaleExample,
  code: '''Column(
  children: [
    Text('Heading 1').h1(),
    Text('Heading 2').h2(),
    Text('Heading 3').h3(),
    Text('Lead text').lead(),
  ],
)''',
);

Widget _buildTextScaleExample(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Heading 1').h1(),
      const SizedBox(height: 6),
      const Text('Heading 2').h2(),
      const SizedBox(height: 6),
      const Text('Heading 3').h3(),
      const SizedBox(height: 6),
      const Text('Lead text for emphasis').lead(),
    ],
  );
}
