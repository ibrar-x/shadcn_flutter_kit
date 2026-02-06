import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'switch_example_1.dart';

const ComponentExample switchExample1 = ComponentExample(
  title: "Switch Example",
  builder: _buildSwitchExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass SwitchExample1 extends StatefulWidget {\n  const SwitchExample1({super.key});\n\n  @override\n  State<SwitchExample1> createState() => _SwitchExample1State();\n}\n\nclass _SwitchExample1State extends State<SwitchExample1> {\n  // Simple on/off state bound to the Switch.\n  bool value = false;\n\n  @override\n  Widget build(BuildContext context) {\n    return Switch(\n      value: value,\n      onChanged: (value) {\n        setState(() {\n          // Flip the switch.\n          this.value = value;\n        });\n      },\n    );\n  }\n}\n",
);

Widget _buildSwitchExample1(BuildContext context) {
  return const SwitchExample1();
}

const List<ComponentExample> switchExamples = [
  switchExample1,
];
