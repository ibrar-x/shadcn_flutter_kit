import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'slider_example_1.dart';
import 'slider_example_2.dart';
import 'slider_example_3.dart';
import 'slider_example_4.dart';

const ComponentExample sliderExample1 = ComponentExample(
  title: 'Brightness Slider',
  builder: _buildSliderExample1,
  code:
      "import 'package:docs/shadcn_ui.dart';\n\nclass SliderExample1 extends StatefulWidget {\n  const SliderExample1({super.key});\n\n  @override\n  State<SliderExample1> createState() => _SliderExample1State();\n}\n\nclass _SliderExample1State extends State<SliderExample1> {\n  double value = 0.64;\n\n  @override\n  Widget build(BuildContext context) {\n    return BrightnessSlider(\n      value: value,\n      onChanged: (next) {\n        setState(() => value = next);\n      },\n    );\n  }\n}\n",
);

Widget _buildSliderExample1(BuildContext context) {
  return const SliderExample1();
}

const ComponentExample sliderExample2 = ComponentExample(
  title: 'Range Slider',
  builder: _buildSliderExample2,
  code:
      "import 'package:docs/shadcn_ui.dart';\nimport 'package:docs/ui/shadcn/components/form/slider/_impl/core/shad_slider_models.dart'\n    show ShadRangeValue;\n\nclass SliderExample2 extends StatefulWidget {\n  const SliderExample2({super.key});\n\n  @override\n  State<SliderExample2> createState() => _SliderExample2State();\n}\n\nclass _SliderExample2State extends State<SliderExample2> {\n  ShadRangeValue value = const ShadRangeValue(240, 980, minRange: 120);\n\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        RangeSoftSlider(\n          min: 0,\n          max: 1600,\n          rangeValue: value,\n          onChanged: (next) {\n            setState(() => value = next);\n          },\n        ),\n        const Gap(16),\n        Text(\n          'Price: \$' + value.start.round().toString() + ' - \$' + value.end.round().toString(),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildSliderExample2(BuildContext context) {
  return const SliderExample2();
}

const ComponentExample sliderExample3 = ComponentExample(
  title: 'Steps + Dots Slider',
  builder: _buildSliderExample3,
  code:
      "import 'package:docs/shadcn_ui.dart';\n\nclass SliderExample3 extends StatefulWidget {\n  const SliderExample3({super.key});\n\n  @override\n  State<SliderExample3> createState() => _SliderExample3State();\n}\n\nclass _SliderExample3State extends State<SliderExample3> {\n  double value = 6;\n\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        StepsDotsSlider(\n          min: 0,\n          max: 12,\n          steps: 12,\n          value: value,\n          onChanged: (next) {\n            setState(() => value = next);\n          },\n        ),\n        const Gap(16),\n        Text('Step: \${value.round()}'),\n      ],\n    );\n  }\n}\n",
);

Widget _buildSliderExample3(BuildContext context) {
  return const SliderExample3();
}

const ComponentExample sliderExample4 = ComponentExample(
  title: 'Wave Slider (Pricing)',
  builder: _buildSliderExample4,
  code:
      "import 'package:docs/shadcn_ui.dart';\nimport 'package:docs/ui/shadcn/components/form/slider/_impl/core/shad_slider_models.dart'\n    show ShadPopoverVisibility;\nimport 'package:docs/ui/shadcn/components/form/slider/_impl/styles/shad_slider_defaults.dart'\n    show ShadSliderDefaults;\n\nclass SliderExample4 extends StatefulWidget {\n  const SliderExample4({super.key});\n\n  @override\n  State<SliderExample4> createState() => _SliderExample4State();\n}\n\nclass _SliderExample4State extends State<SliderExample4> {\n  double price = 420;\n\n  static const List<double> samples = [\n    0.12, 0.2, 0.32, 0.44, 0.51, 0.58, 0.64, 0.55, 0.7, 0.82, 0.68,\n    0.5, 0.62, 0.74, 0.66, 0.53, 0.42, 0.37, 0.29, 0.24, 0.2, 0.16,\n  ];\n\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      crossAxisAlignment: CrossAxisAlignment.start,\n      children: [\n        WaveSlider.domain(\n          min: 120,\n          max: 1600,\n          value: price,\n          samples: samples,\n          onChanged: (next) => setState(() => price = next),\n          valueFormatter: (value) => '\$' + value.round().toString(),\n          popoverVisibility: ShadPopoverVisibility.always,\n          popoverBuilder: ShadSliderDefaults.valuePopoverPill(\n            formatter: (value) => '\$' + value.round().toString(),\n          ),\n        ),\n        const Gap(12),\n        Text('Selected: \$' + price.round().toString()),\n      ],\n    );\n  }\n}\n",
);

Widget _buildSliderExample4(BuildContext context) {
  return const SliderExample4();
}

const List<ComponentExample> sliderExamples = [
  sliderExample1,
  sliderExample2,
  sliderExample3,
  sliderExample4,
];
