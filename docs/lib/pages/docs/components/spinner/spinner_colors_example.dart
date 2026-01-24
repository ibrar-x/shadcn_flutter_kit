import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import 'spinner_shared.dart';

const ComponentExample spinnerColorsExample = ComponentExample(
  title: 'Accent colors',
  builder: _buildSpinnerColorsExample,
  code: '''CircleSpinner(color: Colors.blue)''',
);

Widget _buildSpinnerColorsExample(BuildContext context) {
  return const Wrap(
    spacing: 16,
    runSpacing: 12,
    alignment: WrapAlignment.center,
    children: [
      CircleSpinner(color: Color(0xff7EA3FF)),
      CircleSpinner(color: Color(0xff22c55e)),
      CircleSpinner(color: Color(0xfff97316)),
      CircleSpinner(color: Color(0xffef4444)),
    ],
  );
}
