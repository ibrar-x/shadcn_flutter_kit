import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/layout/hidden/hidden.dart'
    as shadcn_hidden;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;

const ComponentExample hiddenVerticalExample = ComponentExample(
  title: 'Vertical animation',
  builder: _buildHiddenVerticalExample,
  code: '''Hidden(
  hidden: isHidden,
  direction: Axis.vertical,
  child: OutlinedContainer(child: Text('Animated vertically')),
)''',
);

Widget _buildHiddenVerticalExample(BuildContext context) {
  return const _HiddenVerticalExample();
}

class _HiddenVerticalExample extends StatefulWidget {
  const _HiddenVerticalExample();

  @override
  State<_HiddenVerticalExample> createState() => _HiddenVerticalExampleState();
}

class _HiddenVerticalExampleState extends State<_HiddenVerticalExample> {
  bool _hidden = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shadcn_buttons.PrimaryButton(
          onPressed: () => setState(() => _hidden = !_hidden),
          child: Text(_hidden ? 'Show' : 'Hide'),
        ),
        const SizedBox(height: 16),
        shadcn_hidden.Hidden(
          hidden: _hidden,
          direction: Axis.vertical,
          child: const shadcn_outlined.OutlinedContainer(
            padding: EdgeInsets.all(16),
            child: Text('Slides vertically'),
          ),
        ),
      ],
    );
  }
}
