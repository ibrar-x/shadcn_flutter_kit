import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/display/number_ticker/number_ticker.dart'
    as shadcn_ticker;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample numberTickerStatExample = ComponentExample(
  title: 'Stat card',
  builder: _buildNumberTickerStatExample,
  code: '''NumberTicker(
  number: value,
  formatter: (value) => value.toStringAsFixed(0),
  style: TextStyle(fontSize: 28),
)''',
);

Widget _buildNumberTickerStatExample(BuildContext context) {
  return const _NumberTickerStatExample();
}

class _NumberTickerStatExample extends StatefulWidget {
  const _NumberTickerStatExample();

  @override
  State<_NumberTickerStatExample> createState() =>
      _NumberTickerStatExampleState();
}

class _NumberTickerStatExampleState extends State<_NumberTickerStatExample> {
  double _value = 4820;

  void _add(int delta) {
    setState(() => _value += delta);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Active users').small().muted(),
        const SizedBox(height: 6),
        shadcn_ticker.NumberTicker(
          initialNumber: 0,
          number: _value,
          formatter: (value) => value.toStringAsFixed(0),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            shadcn_buttons.OutlineButton(
              onPressed: () => _add(120),
              child: const Text('+120'),
            ),
            shadcn_buttons.OutlineButton(
              onPressed: () => _add(-80),
              child: const Text('-80'),
            ),
          ],
        ),
      ],
    );
  }
}
