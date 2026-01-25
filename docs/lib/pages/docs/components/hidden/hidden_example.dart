import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/layout/hidden/hidden.dart'
    as shadcn_hidden;

const ComponentExample hiddenExample = ComponentExample(
  title: 'Hidden',
  builder: _buildHiddenExample,
  code: '''Hidden(
  hidden: isHidden,
  child: OutlinedContainer(child: Text('Hidden content')),
)''',
);

Widget _buildHiddenExample(BuildContext context) {
  return const _HiddenExample();
}

class _HiddenExample extends StatefulWidget {
  const _HiddenExample();

  @override
  State<_HiddenExample> createState() => _HiddenExampleState();
}

class _HiddenExampleState extends State<_HiddenExample> {
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
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF374151)),
            ),
            child: const Text('Hidden content'),
          ),
        ),
      ],
    );
  }
}
