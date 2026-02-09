import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/border_loading/border_loading.dart'
    as shadcn_border_loading;
import '../../component_example_models.dart';

const ComponentExample borderLoadingTracerExample = ComponentExample(
  title: 'Tracer mode',
  builder: _buildBorderLoadingTracerExample,
  code: '''BorderLoading(
  mode: BorderLoadingMode.tracer,
  tracer: BorderTracerSpec(lengthFraction: 0.12, dashCount: 2),
  spec: BorderGradientSpec(
    type: BorderGradientType.linear,
    colors: [Color(0xFF3B82F6), Color(0xFF22C55E)],
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    child: Text('Uploading...'),
  ),
)''',
);

Widget _buildBorderLoadingTracerExample(BuildContext context) {
  return const shadcn_border_loading.BorderLoading(
    mode: shadcn_border_loading.BorderLoadingMode.tracer,
    tracer: shadcn_border_loading.BorderTracerSpec(
      lengthFraction: 0.12,
      dashCount: 2,
    ),
    spec: shadcn_border_loading.BorderGradientSpec(
      type: shadcn_border_loading.BorderGradientType.linear,
      colors: [Color(0xFF3B82F6), Color(0xFF22C55E)],
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Text('Uploading...'),
    ),
  );
}
