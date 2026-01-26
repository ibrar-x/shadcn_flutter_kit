import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'animated_value_builder_example_1.dart';
import 'animated_value_builder_example_2.dart';

const ComponentExample animatedValueBuilderExample1 = ComponentExample(
  title: "Example",
  builder: _buildAnimatedValueBuilderExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// AnimatedValueBuilder example: animating between colors.\n///\n/// This demonstrates how [AnimatedValueBuilder] can animate any value\n/// given a `lerp` function. Here we animate a [Color] by using [Color.lerp]\n/// as the interpolation function and switch the target color on button press.\nclass AnimatedValueBuilderExample1 extends StatefulWidget {\n  const AnimatedValueBuilderExample1({super.key});\n\n  @override\n  State<AnimatedValueBuilderExample1> createState() =>\n      _AnimatedValueBuilderExample1State();\n}\n\nclass _AnimatedValueBuilderExample1State\n    extends State<AnimatedValueBuilderExample1> {\n  // A small palette to cycle through.\n  List<Color> colors = [\n    Colors.red,\n    Colors.green,\n    Colors.blue,\n  ];\n  // Index of the current target color.\n  int index = 0;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        AnimatedValueBuilder(\n          // The target value to animate towards.\n          value: colors[index],\n          // Duration of the tween between the previous and new value.\n          duration: const Duration(seconds: 1),\n          // The interpolation method between two colors.\n          lerp: Color.lerp,\n          // The builder exposes the current animated value on each frame.\n          builder: (context, value, child) {\n            return Container(\n              width: 100,\n              height: 100,\n              color: value,\n            );\n          },\n        ),\n        const Gap(32),\n        PrimaryButton(\n          onPressed: () {\n            setState(() {\n              // Move to the next color cyclically to trigger a new animation.\n              index = (index + 1) % colors.length;\n            });\n          },\n          child: const Text('Change Color'),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildAnimatedValueBuilderExample1(BuildContext context) {
  return const AnimatedValueBuilderExample1();
}

const ComponentExample animatedValueBuilderExample2 = ComponentExample(
  title: "Example with Initial Value",
  builder: _buildAnimatedValueBuilderExample2,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// AnimatedValueBuilder example: animating between colors.\n///\n/// This demonstrates how [AnimatedValueBuilder] can animate any value\n/// given a `lerp` function. Here we animate a [Color] by using [Color.lerp]\n/// as the interpolation function and switch the target color on button press.\nclass AnimatedValueBuilderExample1 extends StatefulWidget {\n  const AnimatedValueBuilderExample1({super.key});\n\n  @override\n  State<AnimatedValueBuilderExample1> createState() =>\n      _AnimatedValueBuilderExample1State();\n}\n\nclass _AnimatedValueBuilderExample1State\n    extends State<AnimatedValueBuilderExample1> {\n  // A small palette to cycle through.\n  List<Color> colors = [\n    Colors.red,\n    Colors.green,\n    Colors.blue,\n  ];\n  // Index of the current target color.\n  int index = 0;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        AnimatedValueBuilder(\n          // The target value to animate towards.\n          value: colors[index],\n          // Duration of the tween between the previous and new value.\n          duration: const Duration(seconds: 1),\n          // The interpolation method between two colors.\n          lerp: Color.lerp,\n          // The builder exposes the current animated value on each frame.\n          builder: (context, value, child) {\n            return Container(\n              width: 100,\n              height: 100,\n              color: value,\n            );\n          },\n        ),\n        const Gap(32),\n        PrimaryButton(\n          onPressed: () {\n            setState(() {\n              // Move to the next color cyclically to trigger a new animation.\n              index = (index + 1) % colors.length;\n            });\n          },\n          child: const Text('Change Color'),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildAnimatedValueBuilderExample2(BuildContext context) {
  return const AnimatedValueBuilderExample2();
}

const List<ComponentExample> animatedValueBuilderExamples = [
  animatedValueBuilderExample1,
  animatedValueBuilderExample2,
];
