import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/linear_progress_indicator/linear_progress_indicator.dart'
    as shadcn_linear;

const ComponentExample linearProgressSparksExample = ComponentExample(
  title: 'Rounded + Sparks',
  builder: _buildLinearProgressSparksExample,
  code: '''LinearProgressIndicator(
  value: 0.72,
  minHeight: 6,
  showSparks: true,
  borderRadius: BorderRadius.all(Radius.circular(999)),
)''',
);

Widget _buildLinearProgressSparksExample(BuildContext context) {
  return const SizedBox(
    width: 260,
    child: shadcn_linear.LinearProgressIndicator(
      value: 0.72,
      minHeight: 6,
      showSparks: true,
      borderRadius: BorderRadius.all(Radius.circular(999)),
    ),
  );
}
