import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/alpha/alpha.dart';

const ComponentExample alphaBasicExample = ComponentExample(
  title: 'Checkerboard',
  builder: _buildAlphaBasicExample,
  code: '''SizedBox(
  width: 160,
  height: 96,
  child: CustomPaint(
    painter: AlphaPainter(),
  ),
)''',
);

Widget _buildAlphaBasicExample(BuildContext context) {
  return SizedBox(
    width: 160,
    height: 96,
    child: CustomPaint(
      painter: AlphaPainter(),
    ),
  );
}
