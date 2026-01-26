import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'number_input_example_1.dart';

const ComponentExample numberInputExample1 = ComponentExample(
  title: "Example",
  builder: _buildNumberInputExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass NumberInputExample1 extends StatefulWidget {\n  const NumberInputExample1({super.key});\n\n  @override\n  State<NumberInputExample1> createState() => _NumberInputExample1State();\n}\n\nclass _NumberInputExample1State extends State<NumberInputExample1> {\n  double value = 0;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        SizedBox(\n          width: 100,\n          child: TextField(\n            initialValue: value.toString(),\n            onChanged: (value) {\n              setState(() {\n                this.value = double.tryParse(value) ?? 0;\n              });\n            },\n            features: const [\n              // Adds stepper/spinner controls to nudge the value up/down.\n              InputFeature.spinner(),\n            ],\n            submitFormatters: [\n              // Allow math expressions (e.g., 1+2*3) that resolve on submit.\n              TextInputFormatters.mathExpression(),\n            ],\n          ),\n        ),\n        gap(8),\n        Text('Value: \$value'),\n      ],\n    );\n  }\n}\n",
);

Widget _buildNumberInputExample1(BuildContext context) {
  return const NumberInputExample1();
}

const List<ComponentExample> numberInputExamples = [
  numberInputExample1,
];