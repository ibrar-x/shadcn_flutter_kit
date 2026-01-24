import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/selectable/selectable.dart'
    as shadcn_selectable;

const ComponentExample selectableRichExample = ComponentExample(
  title: 'Rich text selection',
  builder: _buildSelectableRichExample,
  code: '''SelectableText.rich(
  TextSpan(
    text: 'Select ',
    children: [
      TextSpan(text: 'highlighted', style: TextStyle(fontWeight: FontWeight.w600)),
      TextSpan(text: ' segments.'),
    ],
  ),
)''',
);

Widget _buildSelectableRichExample(BuildContext context) {
  return const shadcn_selectable.SelectableText.rich(
    TextSpan(
      text: 'Select ',
      children: [
        TextSpan(
          text: 'highlighted',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        TextSpan(text: ' segments and copy them.'),
      ],
    ),
  );
}
