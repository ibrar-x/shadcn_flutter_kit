import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/utility/wrapper/wrapper.dart';

const ComponentExample wrapperToggleExample = ComponentExample(
  title: 'Toggle wrapper',
  builder: _buildWrapperToggleExample,
  code: '''Wrapper(
  wrap: isWrapped,
  maintainStructure: true,
  builder: (context, child) => DecoratedBox(
    decoration: BoxDecoration(
      color: Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: child,
    ),
  ),
  child: const Text('Toggle me'),
)''',
);

Widget _buildWrapperToggleExample(BuildContext context) {
  return const _WrapperToggleExample();
}

class _WrapperToggleExample extends StatefulWidget {
  const _WrapperToggleExample();

  @override
  State<_WrapperToggleExample> createState() => _WrapperToggleExampleState();
}

class _WrapperToggleExampleState extends State<_WrapperToggleExample> {
  bool _wrapped = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrapper(
          wrap: _wrapped,
          maintainStructure: true,
          builder: (context, child) => DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: child,
            ),
          ),
          child: const Text('Toggle me'),
        ),
        const SizedBox(height: 12),
        shadcn_buttons.PrimaryButton(
          onPressed: () => setState(() => _wrapped = !_wrapped),
          child: Text(_wrapped ? 'Disable wrap' : 'Enable wrap'),
        ),
      ],
    );
  }
}
