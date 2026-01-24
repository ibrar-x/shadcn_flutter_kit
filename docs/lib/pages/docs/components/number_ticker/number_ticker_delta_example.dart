import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/display/number_ticker/number_ticker.dart'
    as shadcn_ticker;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample numberTickerDeltaExample = ComponentExample(
  title: 'Delta indicator',
  builder: _buildNumberTickerDeltaExample,
  code: r'''NumberTicker.builder(
  number: value,
  builder: (context, value, child) => Text('${value.toStringAsFixed(1)}%'),
)''',
);

Widget _buildNumberTickerDeltaExample(BuildContext context) {
  return const _NumberTickerDeltaExample();
}

class _NumberTickerDeltaExample extends StatefulWidget {
  const _NumberTickerDeltaExample();

  @override
  State<_NumberTickerDeltaExample> createState() =>
      _NumberTickerDeltaExampleState();
}

class _NumberTickerDeltaExampleState extends State<_NumberTickerDeltaExample> {
  double _value = 6.4;

  void _shift(double delta) {
    setState(() => _value = (_value + delta));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        shadcn_ticker.NumberTicker.builder(
          initialNumber: 0,
          number: _value,
          builder: (context, value, child) {
            final isPositive = value >= 0;
            return Text(
              '${isPositive ? '+' : ''}${value.toStringAsFixed(1)}%',
            ).mono.semiBold(
                  color: isPositive
                      ? const Color(0xff22c55e)
                      : const Color(0xffef4444),
                );
          },
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            shadcn_buttons.PrimaryButton(
              onPressed: () => _shift(1.2),
              child: const Text('+1.2'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () => _shift(-1.2),
              child: const Text('-1.2'),
            ),
          ],
        ),
      ],
    );
  }
}
