import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/text_area/text_area.dart'
    as shadcn_text_area;

const ComponentExample textAreaExpandBothExample = ComponentExample(
  title: 'Expandable width & height',
  builder: _buildTextAreaExpandBothExample,
  code: '''TextArea(
  initialValue: 'Hello, World!',
  expandableWidth: true,
  expandableHeight: true,
  initialWidth: 500,
  initialHeight: 300,
)''',
);

Widget _buildTextAreaExpandBothExample(BuildContext context) {
  return const shadcn_text_area.TextArea(
    initialValue: 'Hello, World!',
    expandableWidth: true,
    expandableHeight: true,
    initialWidth: 500,
    initialHeight: 300,
  );
}
