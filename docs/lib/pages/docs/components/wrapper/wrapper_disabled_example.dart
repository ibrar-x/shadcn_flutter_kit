import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/wrapper/wrapper.dart';

const ComponentExample wrapperDisabledExample = ComponentExample(
  title: 'Wrap disabled',
  builder: _buildWrapperDisabledExample,
  code: '''Wrapper(
  wrap: false,
  builder: (context, child) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF111827),
      borderRadius: BorderRadius.circular(12),
    ),
    child: child,
  ),
  child: const Text('Raw content'),
)''',
);

Widget _buildWrapperDisabledExample(BuildContext context) {
  return Wrapper(
    wrap: false,
    builder: (context, child) => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    ),
    child: const Text('Raw content'),
  );
}
