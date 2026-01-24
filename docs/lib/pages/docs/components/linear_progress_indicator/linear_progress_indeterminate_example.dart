import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/linear_progress_indicator/linear_progress_indicator.dart'
    as shadcn_linear;

const ComponentExample linearProgressIndeterminateExample = ComponentExample(
  title: 'Indeterminate',
  builder: _buildLinearProgressIndeterminateExample,
  code: '''SizedBox(
  width: 200,
  child: LinearProgressIndicator(),
)''',
);

Widget _buildLinearProgressIndeterminateExample(BuildContext context) {
  return const SizedBox(
    width: 200,
    child: shadcn_linear.LinearProgressIndicator(),
  );
}
