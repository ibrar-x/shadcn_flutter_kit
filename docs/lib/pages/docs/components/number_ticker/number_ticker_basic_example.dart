import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/number_ticker/number_ticker.dart'
    as shadcn_ticker;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;

const ComponentExample numberTickerBasicExample = ComponentExample(
  title: 'Basic ticker',
  builder: _buildNumberTickerBasicExample,
  code: '''NumberTicker(
  initialNumber: 0,
  number: value,
  formatter: (value) => NumberFormat.compact().format(value),
)''',
);

Widget _buildNumberTickerBasicExample(BuildContext context) {
  return const _NumberTickerBasicExample();
}

class _NumberTickerBasicExample extends StatefulWidget {
  const _NumberTickerBasicExample();

  @override
  State<_NumberTickerBasicExample> createState() =>
      _NumberTickerBasicExampleState();
}

class _NumberTickerBasicExampleState extends State<_NumberTickerBasicExample> {
  int _number = 1280;
  late final TextEditingController _controller = TextEditingController(
    text: _number.toString(),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _commit() {
    final next = int.tryParse(_controller.text);
    if (next == null) return;
    setState(() => _number = next);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        shadcn_ticker.NumberTicker(
          initialNumber: 0,
          number: _number,
          formatter: (value) => NumberFormat.compact().format(value),
          style: const TextStyle(fontSize: 32),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 200,
          child: shadcn_text_field.TextField(
            controller: _controller,
            hintText: 'Enter number',
            onEditingComplete: _commit,
          ),
        ),
      ],
    );
  }
}
