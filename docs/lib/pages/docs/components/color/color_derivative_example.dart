import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/color/color.dart';

const ComponentExample colorDerivativeExample = ComponentExample(
  title: 'Color derivatives',
  builder: _buildColorDerivativeExample,
  code: '''final base = ColorDerivative.fromColor(Color(0xFF4F46E5));
final muted = base.changeToHSVSaturation(0.35);
final bright = base.changeToHSVValue(1.0);

Row(
  children: [
    _Swatch(base.toColor()),
    _Swatch(muted.toColor()),
    _Swatch(bright.toColor()),
  ],
)''',
);

Widget _buildColorDerivativeExample(BuildContext context) {
  final base = ColorDerivative.fromColor(const Color(0xFF4F46E5));
  final muted = base.changeToHSVSaturation(0.35);
  final bright = base.changeToHSVValue(1.0);
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      _Swatch(color: base.toColor()),
      _Swatch(color: muted.toColor()),
      _Swatch(color: bright.toColor()),
    ],
  );
}

class _Swatch extends StatelessWidget {
  final Color color;

  const _Swatch({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
