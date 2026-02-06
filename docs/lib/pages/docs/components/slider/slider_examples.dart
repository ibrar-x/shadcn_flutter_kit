import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'slider_example_1.dart';
import 'slider_example_2.dart';
import 'slider_example_3.dart';

const ComponentExample sliderExample1 = ComponentExample(
  title: "Slider Example",
  builder: _buildSliderExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass SliderExample1 extends StatefulWidget {\n  const SliderExample1({super.key});\n\n  @override\n  State<SliderExample1> createState() => _SliderExample1State();\n}\n\nclass _SliderExample1State extends State<SliderExample1> {\n  // A single-value slider in the 0\u20131 range (default).\n  SliderValue value = const SliderValue.single(0.5);\n  @override\n  Widget build(BuildContext context) {\n    return Slider(\n      value: value,\n      onChanged: (value) {\n        setState(() {\n          // Update local state when the thumb is dragged.\n          this.value = value;\n        });\n      },\n    );\n  }\n}\n",
);

Widget _buildSliderExample1(BuildContext context) {
  return const SliderExample1();
}

const ComponentExample sliderExample2 = ComponentExample(
  title: "Slider with Range Example",
  builder: _buildSliderExample2,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass SliderExample2 extends StatefulWidget {\n  const SliderExample2({super.key});\n\n  @override\n  State<SliderExample2> createState() => _SliderExample2State();\n}\n\nclass _SliderExample2State extends State<SliderExample2> {\n  // A ranged slider has a start and end thumb/value.\n  SliderValue value = const SliderValue.ranged(0.5, 0.75);\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        Slider(\n          value: value,\n          onChanged: (value) {\n            setState(() {\n              this.value = value;\n            });\n          },\n        ),\n        const Gap(16),\n        // Display the current ranged values below the slider.\n        Text('Value: \${value.start} - \${value.end}'),\n      ],\n    );\n  }\n}\n",
);

Widget _buildSliderExample2(BuildContext context) {
  return const SliderExample2();
}

const ComponentExample sliderExample3 = ComponentExample(
  title: "Slider with Divisions Example",
  builder: _buildSliderExample3,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass SliderExample3 extends StatefulWidget {\n  const SliderExample3({super.key});\n\n  @override\n  State<SliderExample3> createState() => _SliderExample3State();\n}\n\nclass _SliderExample3State extends State<SliderExample3> {\n  // Single-value slider with a custom range and discrete divisions.\n  SliderValue value = const SliderValue.single(0.5);\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        Slider(\n          // Allow values from 0 to 2 with 10 discrete steps.\n          max: 2,\n          divisions: 10,\n          value: value,\n          onChanged: (value) {\n            setState(() {\n              this.value = value;\n            });\n          },\n        ),\n        const Gap(16),\n        // Show the current numeric value.\n        Text('Value: \${value.value}'),\n      ],\n    );\n  }\n}\n",
);

Widget _buildSliderExample3(BuildContext context) {
  return const SliderExample3();
}

const List<ComponentExample> sliderExamples = [
  sliderExample1,
  sliderExample2,
  sliderExample3,
];