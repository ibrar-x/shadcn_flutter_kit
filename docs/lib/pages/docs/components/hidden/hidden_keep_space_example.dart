import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/layout/hidden/hidden.dart'
    as shadcn_hidden;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;

const ComponentExample hiddenKeepSpaceExample = ComponentExample(
  title: 'Keep space',
  builder: _buildHiddenKeepSpaceExample,
  code: '''Hidden(
  hidden: isHidden,
  keepMainAxisSize: true,
  child: OutlinedContainer(child: Text('Hidden content')),
)''',
);

Widget _buildHiddenKeepSpaceExample(BuildContext context) {
  return const _HiddenKeepSpaceExample();
}

class _HiddenKeepSpaceExample extends StatefulWidget {
  const _HiddenKeepSpaceExample();

  @override
  State<_HiddenKeepSpaceExample> createState() =>
      _HiddenKeepSpaceExampleState();
}

class _HiddenKeepSpaceExampleState extends State<_HiddenKeepSpaceExample> {
  bool _hidden = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shadcn_buttons.SecondaryButton(
          onPressed: () => setState(() => _hidden = !_hidden),
          child: Text(_hidden ? 'Show' : 'Hide'),
        ),
        const SizedBox(height: 16),
        shadcn_hidden.Hidden(
          hidden: _hidden,
          keepMainAxisSize: true,
          child: const shadcn_outlined.OutlinedContainer(
            padding: EdgeInsets.all(16),
            child: Text('Keeps space when hidden'),
          ),
        ),
      ],
    );
  }
}
