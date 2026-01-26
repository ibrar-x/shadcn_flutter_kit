import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/display/circular_progress_indicator/circular_progress_indicator.dart'
    as shadcn_circular;

const ComponentExample circularProgressDeterminateExample = ComponentExample(
  title: 'Determinate with controls',
  builder: _buildCircularProgressDeterminateExample,
  code: '''
CircularProgressIndicator(value: 0.6)
''',
);

Widget _buildCircularProgressDeterminateExample(BuildContext context) {
  return const _CircularProgressDeterminateExample();
}

class _CircularProgressDeterminateExample extends StatefulWidget {
  const _CircularProgressDeterminateExample();

  @override
  State<_CircularProgressDeterminateExample> createState() =>
      _CircularProgressDeterminateExampleState();
}

class _CircularProgressDeterminateExampleState
    extends State<_CircularProgressDeterminateExample> {
  double _progress = 0.4;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        shadcn_circular.CircularProgressIndicator(value: _progress, size: 52),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            shadcn_buttons.DestructiveButton(
              onPressed: () => setState(() => _progress = 0),
              child: const Text('Reset'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () =>
                  setState(() => _progress = (_progress - 0.1).clamp(0.0, 1.0)),
              child: const Text('Decrease'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () =>
                  setState(() => _progress = (_progress + 0.1).clamp(0.0, 1.0)),
              child: const Text('Increase'),
            ),
          ],
        ),
      ],
    );
  }
}
