import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/text_area/text_area.dart'
    as shadcn_text_area;

const ComponentExample textAreaExpandHeightExample = ComponentExample(
  title: 'Expandable height',
  builder: _buildTextAreaExpandHeightExample,
  code: '''TextArea(
  initialValue: 'Hello, World!',
  expandableHeight: true,
  initialHeight: 300,
)''',
);

Widget _buildTextAreaExpandHeightExample(BuildContext context) {
  return const shadcn_text_area.TextArea(
    initialValue: 'Hello, World!',
    expandableHeight: true,
    initialHeight: 300,
  );
}
