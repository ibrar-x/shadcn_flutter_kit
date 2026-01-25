import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/alpha/alpha.dart';

const ComponentExample alphaRoundedExample = ComponentExample(
  title: 'Rounded sample',
  builder: _buildAlphaRoundedExample,
  code: '''SizedBox(
  width: 160,
  height: 96,
  child: ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    child: Stack(
      children: [
        CustomPaint(
          painter: AlphaPainter(),
          size: Size.infinite,
        ),
        Positioned.fill(
          child: ColoredBox(
            color: Color(0x664ADE80),
          ),
        ),
      ],
    ),
  ),
)''',
);

Widget _buildAlphaRoundedExample(BuildContext context) {
  return const SizedBox(
    width: 160,
    height: 96,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Stack(
        children: [
          CustomPaint(
            painter: AlphaPainter(),
            size: Size.infinite,
          ),
          Positioned.fill(
            child: ColoredBox(
              color: Color(0x664ADE80),
            ),
          ),
        ],
      ),
    ),
  );
}
