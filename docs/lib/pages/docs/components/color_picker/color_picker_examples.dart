import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'color_picker_example_1.dart';

const ComponentExample colorPickerExample1 = ComponentExample(
  title: "Color Input Example",
  builder: _buildColorPickerExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass ColorPickerExample1 extends StatefulWidget {\n  const ColorPickerExample1({super.key});\n\n  @override\n  State<ColorPickerExample1> createState() => _ColorPickerExample1State();\n}\n\nclass _ColorPickerExample1State extends State<ColorPickerExample1> {\n  ColorDerivative color = ColorDerivative.fromColor(Colors.blue);\n  @override\n  Widget build(BuildContext context) {\n    return SizedBox(\n      width: 200,\n      child: Column(\n        crossAxisAlignment: CrossAxisAlignment.start,\n        children: [\n          SizedBox(\n            width: 32,\n            height: 32,\n            child: ColorInput(\n              // A compact square color input that opens a popover prompt.\n              value: color,\n              orientation: Axis.horizontal,\n              promptMode: PromptMode.popover,\n              onChanged: (value) {\n                setState(() {\n                  color = value;\n                });\n              },\n            ),\n          ),\n          const Gap(16),\n          ColorInput(\n            value: color,\n            // Full dialog mode with a title.\n            promptMode: PromptMode.dialog,\n            dialogTitle: const Text('Select Color'),\n            onChanged: (value) {\n              setState(() {\n                color = value;\n              });\n            },\n            // Show the textual label/hex alongside the swatch.\n            showLabel: true,\n          ),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildColorPickerExample1(BuildContext context) {
  return const ColorPickerExample1();
}

const List<ComponentExample> colorPickerExamples = [
  colorPickerExample1,
];
