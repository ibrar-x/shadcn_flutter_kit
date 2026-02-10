import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'text_animate_example_shared.dart';

const ComponentExample textAnimateUniversalControlsExample = ComponentExample(
  title: 'Universal Animation Speed',
  builder: _buildTextAnimateUniversalControlsExample,
  code: '''// Shared page-level control for all text_animate demos.
// Higher value => slower stream updates and slower effect settling.

textAnimateGlobalSlowFactor.value = 1.0; // default

Slider(
  min: 0.5,
  max: 2.5,
  value: textAnimateGlobalSlowFactor.value,
  onChanged: (value) => textAnimateGlobalSlowFactor.value = value,
)''',
);

Widget _buildTextAnimateUniversalControlsExample(BuildContext context) {
  return const TextAnimateUniversalSpeedControl();
}
