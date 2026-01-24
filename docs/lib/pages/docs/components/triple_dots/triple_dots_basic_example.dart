import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/triple_dots/triple_dots.dart';

const ComponentExample tripleDotsBasicExample = ComponentExample(
  title: 'Default dots',
  builder: _buildTripleDotsBasicExample,
  code: '''MoreDots()''',
);

Widget _buildTripleDotsBasicExample(BuildContext context) {
  return const MoreDots();
}
