import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/display/linear_progress_indicator/linear_progress_indicator.dart'
    as shadcn_linear;

const ComponentExample linearProgressDeterminateExample = ComponentExample(
  title: 'Determinate',
  builder: _buildLinearProgressDeterminateExample,
  code: '''LinearProgressIndicator(value: 0.4)''',
);

Widget _buildLinearProgressDeterminateExample(BuildContext context) {
  return const _LinearProgressDeterminateExample();
}

class _LinearProgressDeterminateExample extends StatefulWidget {
  const _LinearProgressDeterminateExample();

  @override
  State<_LinearProgressDeterminateExample> createState() =>
      _LinearProgressDeterminateExampleState();
}

class _LinearProgressDeterminateExampleState
    extends State<_LinearProgressDeterminateExample> {
  double _value = 0.4;

  void _update(double delta) {
    setState(() {
      _value = (_value + delta).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 220,
          child: shadcn_linear.LinearProgressIndicator(value: _value),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            shadcn_buttons.PrimaryButton(
              onPressed: () => _update(-0.2),
              child: const Text('-20%'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () => _update(0.2),
              child: const Text('+20%'),
            ),
            shadcn_buttons.OutlineButton(
              onPressed: () => setState(() => _value = 0.0),
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}
