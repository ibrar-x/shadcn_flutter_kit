import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/circular_progress_indicator/circular_progress_indicator.dart'
    as shadcn_circular;

const ComponentExample circularProgressSizesExample = ComponentExample(
  title: 'Sizes',
  builder: _buildCircularProgressSizesExample,
  code: '''
CircularProgressIndicator(size: 24)
CircularProgressIndicator(size: 36)
CircularProgressIndicator(size: 48)
''',
);

Widget _buildCircularProgressSizesExample(BuildContext context) {
  return const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      shadcn_circular.CircularProgressIndicator(size: 24),
      SizedBox(width: 16),
      shadcn_circular.CircularProgressIndicator(size: 36),
      SizedBox(width: 16),
      shadcn_circular.CircularProgressIndicator(size: 48),
    ],
  );
}
