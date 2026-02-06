import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'number_ticker_example_1.dart';

const ComponentExample numberTickerExample1 = ComponentExample(
  title: "Example",
  builder: _buildNumberTickerExample1,
  code: "import 'package:intl/intl.dart';\nimport 'package:docs/shadcn_ui.dart';\n\n// Demonstrates NumberTicker animating from its previous value to a new value.\n// The TextField lets you enter a target integer; committing the edit triggers\n// the ticker to animate the change. A formatter compact-prints large numbers.\n\nclass NumberTickerExample1 extends StatefulWidget {\n  const NumberTickerExample1({super.key});\n\n  @override\n  State<NumberTickerExample1> createState() => _NumberTickerExample1State();\n}\n\nclass _NumberTickerExample1State extends State<NumberTickerExample1> {\n  // Current target number. Changing this causes NumberTicker to animate\n  // from the old value to the new value.\n  int _number = 0;\n  final TextEditingController _controller = TextEditingController();\n\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        NumberTicker(\n          // Starting point for the first animation frame.\n          initialNumber: 0,\n          // The live value to animate toward. When this changes, the ticker\n          // interpolates between the previous and the new value.\n          number: _number,\n          style: const TextStyle(fontSize: 32),\n          formatter: (number) {\n            // Optional display formatter: 1200 -> 1.2K, etc.\n            return NumberFormat.compact().format(number);\n          },\n        ),\n        const Gap(24),\n        TextField(\n          // Show the current number as the initial text.\n          initialValue: _number.toString(),\n          controller: _controller,\n          onEditingComplete: () {\n            // Commit input on edit complete and update the ticker target.\n            int? number = int.tryParse(_controller.text);\n            if (number != null) {\n              setState(() {\n                _number = number;\n              });\n            }\n          },\n        )\n      ],\n    );\n  }\n}\n",
);

Widget _buildNumberTickerExample1(BuildContext context) {
  return const NumberTickerExample1();
}

const List<ComponentExample> numberTickerExamples = [
  numberTickerExample1,
];
