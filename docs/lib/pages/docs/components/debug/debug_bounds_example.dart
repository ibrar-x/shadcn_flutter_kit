import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/debug/debug.dart';

const ComponentExample debugBoundsExample = ComponentExample(
  title: 'Nested bounds',
  builder: _buildDebugBoundsExample,
  code: '''Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    const Text('Outer').debugContainer(Color(0x3322C55E)),
    const SizedBox(height: 8),
    const Text('Inner').debugContainer(Color(0x3343A5F5)),
  ],
)''',
);

Widget _buildDebugBoundsExample(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Outer').debugContainer(const Color(0x3322C55E)),
      const SizedBox(height: 8),
      const Text('Inner').debugContainer(const Color(0x3343A5F5)),
    ],
  );
}
