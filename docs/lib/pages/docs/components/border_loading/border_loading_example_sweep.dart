import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/border_loading/border_loading.dart'
    as shadcn_border_loading;
import '../../component_example_models.dart';

const ComponentExample borderLoadingSweepExample = ComponentExample(
  title: 'Sweep loading',
  builder: _buildBorderLoadingSweepExample,
  code: '''BorderLoading(
  mode: BorderLoadingMode.sweepGradient,
  spec: BorderGradientSpec(
    type: BorderGradientType.sweep,
    colors: [
      Color(0x00000000),
      Color(0xFF3B82F6),
      Color(0xFF22C55E),
      Color(0xFFF59E0B),
      Color(0x00000000),
    ],
    gap: 0.24,
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    child: Text('Saving...'),
  ),
)''',
);

Widget _buildBorderLoadingSweepExample(BuildContext context) {
  return const shadcn_border_loading.BorderLoading(
    mode: shadcn_border_loading.BorderLoadingMode.sweepGradient,
    spec: shadcn_border_loading.BorderGradientSpec(
      type: shadcn_border_loading.BorderGradientType.sweep,
      colors: [
        Color(0x00000000),
        Color(0xFF3B82F6),
        Color(0xFF22C55E),
        Color(0xFFF59E0B),
        Color(0x00000000),
      ],
      gap: 0.24,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Text('Saving...'),
    ),
  );
}
