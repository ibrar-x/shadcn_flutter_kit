import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'dot_indicator_example_1.dart';

const ComponentExample dotIndicatorExample1 = ComponentExample(
  title: "Example",
  builder: _buildDotIndicatorExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass DotIndicatorExample1 extends StatefulWidget {\n  const DotIndicatorExample1({super.key});\n\n  @override\n  State<DotIndicatorExample1> createState() => _DotIndicatorExample1State();\n}\n\nclass _DotIndicatorExample1State extends State<DotIndicatorExample1> {\n  int _index = 0;\n  @override\n  Widget build(BuildContext context) {\n    // A simple pager-like dot indicator with 5 steps.\n    // Tap/click updates the current index via onChanged.\n    return DotIndicator(\n        index: _index,\n        length: 5,\n        onChanged: (index) {\n          setState(() {\n            _index = index;\n          });\n        });\n  }\n}\n",
);

Widget _buildDotIndicatorExample1(BuildContext context) {
  return const DotIndicatorExample1();
}

const List<ComponentExample> dotIndicatorExamples = [
  dotIndicatorExample1,
];
