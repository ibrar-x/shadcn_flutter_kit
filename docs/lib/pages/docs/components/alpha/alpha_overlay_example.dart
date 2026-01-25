import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/alpha/alpha.dart';

const ComponentExample alphaOverlayExample = ComponentExample(
  title: 'Overlay tint',
  builder: _buildAlphaOverlayExample,
  code: '''SizedBox(
  width: 160,
  height: 96,
  child: Stack(
    children: [
      CustomPaint(
        painter: AlphaPainter(),
        size: Size.infinite,
      ),
      Positioned.fill(
        child: ColoredBox(
          color: Color(0x884F46E5),
        ),
      ),
    ],
  ),
)''',
);

Widget _buildAlphaOverlayExample(BuildContext context) {
  return SizedBox(
    width: 160,
    height: 96,
    child: Stack(
      children: [
        CustomPaint(
          painter: AlphaPainter(),
          size: Size.infinite,
        ),
        const Positioned.fill(
          child: ColoredBox(
            color: Color(0x884F46E5),
          ),
        ),
      ],
    ),
  );
}
