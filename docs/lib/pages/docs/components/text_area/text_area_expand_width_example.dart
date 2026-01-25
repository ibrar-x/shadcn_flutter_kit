import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/text_area/text_area.dart'
    as shadcn_text_area;

const ComponentExample textAreaExpandWidthExample = ComponentExample(
  title: 'Expandable width',
  builder: _buildTextAreaExpandWidthExample,
  code: '''TextArea(
  initialValue: 'Hello, World!',
  expandableWidth: true,
  initialWidth: 500,
)''',
);

Widget _buildTextAreaExpandWidthExample(BuildContext context) {
  return const shadcn_text_area.TextArea(
    initialValue: 'Hello, World!',
    expandableWidth: true,
    initialWidth: 500,
  );
}
