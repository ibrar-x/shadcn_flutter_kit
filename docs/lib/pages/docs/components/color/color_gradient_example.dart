import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/color/color.dart';

const ComponentExample colorGradientExample = ComponentExample(
  title: 'Gradient helpers',
  builder: _buildColorGradientExample,
  code: '''final gradient = LinearColorGradient(
  colors: [
    ColorStop(
      color: ColorDerivative.fromColor(Color(0xFF3B82F6)),
      position: 0.0,
    ),
    ColorStop(
      color: ColorDerivative.fromColor(Color(0xFF22D3EE)),
      position: 1.0,
    ),
  ],
);

Container(
  height: 64,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    gradient: gradient.toGradient(),
  ),
)''',
);

Widget _buildColorGradientExample(BuildContext context) {
  final gradient = LinearColorGradient(
    colors: [
      ColorStop(
        color: ColorDerivative.fromColor(const Color(0xFF3B82F6)),
        position: 0.0,
      ),
      ColorStop(
        color: ColorDerivative.fromColor(const Color(0xFF22D3EE)),
        position: 1.0,
      ),
    ],
  );
  return Container(
    height: 64,
    width: 180,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: gradient.toGradient(),
    ),
  );
}
