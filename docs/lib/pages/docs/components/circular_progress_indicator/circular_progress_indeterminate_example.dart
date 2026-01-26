import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/circular_progress_indicator/circular_progress_indicator.dart'
    as shadcn_circular;

const ComponentExample circularProgressIndeterminateExample = ComponentExample(
  title: 'Indeterminate',
  builder: _buildCircularProgressIndeterminateExample,
  code: '''
CircularProgressIndicator()
''',
);

Widget _buildCircularProgressIndeterminateExample(context) {
  return const shadcn_circular.CircularProgressIndicator();
}
