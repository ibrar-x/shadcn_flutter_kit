import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/wrapper/wrapper.dart';

const ComponentExample wrapperBasicExample = ComponentExample(
  title: 'Basic wrapper',
  builder: _buildWrapperBasicExample,
  code: '''Wrapper(
  wrap: true,
  builder: (context, child) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF111827),
      borderRadius: BorderRadius.circular(12),
    ),
    child: child,
  ),
  child: const Text('Wrapped content'),
)''',
);

Widget _buildWrapperBasicExample(BuildContext context) {
  return Wrapper(
    wrap: true,
    builder: (context, child) => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    ),
    child: const Text('Wrapped content'),
  );
}
