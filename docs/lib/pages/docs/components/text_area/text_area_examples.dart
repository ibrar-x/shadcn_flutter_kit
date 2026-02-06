import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'text_area_example_1.dart';
import 'text_area_example_2.dart';
import 'text_area_example_3.dart';

const ComponentExample textAreaExample1 = ComponentExample(
  title: "Resizable Height Example",
  builder: _buildTextAreaExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n// Demonstrates a TextArea that expands vertically with its content.\n\nclass TextAreaExample1 extends StatelessWidget {\n  const TextAreaExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const TextArea(\n      initialValue: 'Hello, World!',\n      // Let the text area grow vertically with content up to constraints.\n      expandableHeight: true,\n      // Start with a taller initial height to show multiple lines.\n      initialHeight: 300,\n    );\n  }\n}\n",
);

Widget _buildTextAreaExample1(BuildContext context) {
  return const TextAreaExample1();
}

const ComponentExample textAreaExample2 = ComponentExample(
  title: "Resizable Width Example",
  builder: _buildTextAreaExample2,
  code: "import 'package:docs/shadcn_ui.dart';\n\n// Demonstrates a TextArea that can expand horizontally as space permits.\n\nclass TextAreaExample2 extends StatelessWidget {\n  const TextAreaExample2({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const TextArea(\n      initialValue: 'Hello, World!',\n      // Allow the field to expand horizontally if space permits.\n      expandableWidth: true,\n      // Start wider to demonstrate horizontal growth.\n      initialWidth: 500,\n    );\n  }\n}\n",
);

Widget _buildTextAreaExample2(BuildContext context) {
  return const TextAreaExample2();
}

const ComponentExample textAreaExample3 = ComponentExample(
  title: "Resizable Width and Height Example",
  builder: _buildTextAreaExample3,
  code: "import 'package:docs/shadcn_ui.dart';\n\n// Demonstrates a TextArea that expands both horizontally and vertically.\n\nclass TextAreaExample3 extends StatelessWidget {\n  const TextAreaExample3({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const TextArea(\n      initialValue: 'Hello, World!',\n      // Enable both horizontal and vertical growth based on content.\n      expandableWidth: true,\n      expandableHeight: true,\n      // Larger starting dimensions to make the behavior obvious.\n      initialWidth: 500,\n      initialHeight: 300,\n    );\n  }\n}\n",
);

Widget _buildTextAreaExample3(BuildContext context) {
  return const TextAreaExample3();
}

const List<ComponentExample> textAreaExamples = [
  textAreaExample1,
  textAreaExample2,
  textAreaExample3,
];
