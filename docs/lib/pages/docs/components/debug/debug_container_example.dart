import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/debug/debug.dart';

const ComponentExample debugContainerExample = ComponentExample(
  title: 'Debug container',
  builder: _buildDebugContainerExample,
  code: '''const Text('Layout box').debugContainer();''',
);

Widget _buildDebugContainerExample(BuildContext context) {
  return const Text('Layout box').debugContainer();
}
