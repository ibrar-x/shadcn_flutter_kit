import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'spinner_shared.dart';

const ComponentExample spinnerSizesExample = ComponentExample(
  title: 'Sizes',
  builder: _buildSpinnerSizesExample,
  code: '''Wrap(
  spacing: 16,
  children: [
    CircleSpinner(size: 16),
    CircleSpinner(size: 24),
    CircleSpinner(size: 32),
  ],
)''',
);

Widget _buildSpinnerSizesExample(BuildContext context) {
  return const Wrap(
    spacing: 16,
    runSpacing: 12,
    alignment: WrapAlignment.center,
    children: [
      CircleSpinner(size: 16),
      CircleSpinner(size: 24),
      CircleSpinner(size: 32),
      CircleSpinner(size: 40),
    ],
  );
}
