import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/triple_dots/triple_dots.dart';

const ComponentExample tripleDotsVerticalExample = ComponentExample(
  title: 'Vertical dots',
  builder: _buildTripleDotsVerticalExample,
  code: '''MoreDots(direction: Axis.vertical, count: 4)''',
);

Widget _buildTripleDotsVerticalExample(BuildContext context) {
  return const MoreDots(
    direction: Axis.vertical,
    count: 4,
    spacing: 4,
  );
}
