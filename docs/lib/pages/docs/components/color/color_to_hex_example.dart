import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/color/color.dart';

const ComponentExample colorToHexExample = ComponentExample(
  title: 'Color to hex',
  builder: _buildColorToHexExample,
  code: '''final color = Color(0xFF4F46E5);

Text(colorToHex(color, true));''',
);

Widget _buildColorToHexExample(BuildContext context) {
  final color = const Color(0xFF4F46E5);
  return Text(colorToHex(color, true));
}
