import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/text/text.dart';

const ComponentExample textInlineExample = ComponentExample(
  title: 'Inline code + link',
  builder: _buildTextInlineExample,
  code: '''Text('Install with ')
  .thenInlineCode('flutter_shadcn add button')
  .thenButton(onPressed: () {}, child: Text('Copy'))''',
);

Widget _buildTextInlineExample(BuildContext context) {
  return const Text('Install with ')
      .thenInlineCode('flutter_shadcn add button')
      .thenButton(
        onPressed: () {},
        child: const Text('Copy'),
      );
}
