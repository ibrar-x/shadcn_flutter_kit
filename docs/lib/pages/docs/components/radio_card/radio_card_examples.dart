import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'radio_card_example_1.dart';

const ComponentExample radioCardExample1 = ComponentExample(
  title: "Example",
  builder: _buildRadioCardExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass RadioCardExample1 extends StatefulWidget {\n  const RadioCardExample1({super.key});\n\n  @override\n  State<RadioCardExample1> createState() => _RadioCardExample1State();\n}\n\nclass _RadioCardExample1State extends State<RadioCardExample1> {\n  // Currently selected option. The RadioGroup below binds to this value.\n  int value = 1;\n  @override\n  Widget build(BuildContext context) {\n    return RadioGroup(\n      // Provide the selected value so RadioCard children can render checked state.\n      value: value,\n      onChanged: (value) {\n        setState(() {\n          // Update selection when any RadioCard is tapped.\n          this.value = value;\n        });\n      },\n      child: const Row(\n        mainAxisSize: MainAxisSize.min,\n        children: [\n          // Each RadioCard acts as a large tappable radio option.\n          // Assign a unique 'value' for identification within the RadioGroup.\n          RadioCard(\n            value: 1,\n            child: Basic(\n              // 'Basic' is a helper layout that shows a title and a content line.\n              title: Text('8-core CPU'),\n              content: Text('32 GB RAM'),\n            ),\n          ),\n          RadioCard(\n            value: 2,\n            child: Basic(\n              title: Text('6-core CPU'),\n              content: Text('24 GB RAM'),\n            ),\n          ),\n          RadioCard(\n            value: 3,\n            child: Basic(\n              title: Text('4-core CPU'),\n              content: Text('16 GB RAM'),\n            ),\n          ),\n        ],\n      )\n          // Add horizontal spacing between the cards via the .gap extension.\n          .gap(12),\n    );\n  }\n}\n",
);

Widget _buildRadioCardExample1(BuildContext context) {
  return const RadioCardExample1();
}

const List<ComponentExample> radioCardExamples = [
  radioCardExample1,
];
