import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'repeated_animation_builder_example_1.dart';
import 'repeated_animation_builder_example_2.dart';
import 'repeated_animation_builder_example_3.dart';

const ComponentExample repeatedAnimationBuilderExample1 = ComponentExample(
  title: "Example",
  builder: _buildRepeatedAnimationBuilderExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass RepeatedAnimationBuilderExample1 extends StatelessWidget {\n  const RepeatedAnimationBuilderExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return RepeatedAnimationBuilder(\n      // Animate a value from 'start' to 'end' and repeat.\n      // The builder below receives the animated Offset each tick.\n      start: const Offset(-100, 0),\n      end: const Offset(100, 0),\n      // One second per run from start to end.\n      duration: const Duration(seconds: 1),\n      builder: (context, value, child) {\n        return Transform.translate(\n          // Move a square horizontally based on the current animated value.\n          offset: value,\n          child: Container(\n            width: 100,\n            height: 100,\n            color: Colors.red,\n          ),\n        );\n      },\n    );\n  }\n}\n",
);

Widget _buildRepeatedAnimationBuilderExample1(BuildContext context) {
  return const RepeatedAnimationBuilderExample1();
}

const ComponentExample repeatedAnimationBuilderExample2 = ComponentExample(
  title: "Reverse Example",
  builder: _buildRepeatedAnimationBuilderExample2,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass RepeatedAnimationBuilderExample2 extends StatelessWidget {\n  const RepeatedAnimationBuilderExample2({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return RepeatedAnimationBuilder(\n      start: const Offset(-100, 0),\n      end: const Offset(100, 0),\n      duration: const Duration(seconds: 1),\n      // Apply a non-linear easing curve.\n      curve: Curves.easeInOutCubic,\n      // Reverse mode plays forward to 'end', then backward to 'start', and repeats.\n      mode: LoopingMode.reverse,\n      builder: (context, value, child) {\n        return Transform.translate(\n          offset: value,\n          child: Container(\n            width: 100,\n            height: 100,\n            color: Colors.red,\n          ),\n        );\n      },\n    );\n  }\n}\n",
);

Widget _buildRepeatedAnimationBuilderExample2(BuildContext context) {
  return const RepeatedAnimationBuilderExample2();
}

const ComponentExample repeatedAnimationBuilderExample3 = ComponentExample(
  title: "Ping-pong Example",
  builder: _buildRepeatedAnimationBuilderExample3,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass RepeatedAnimationBuilderExample3 extends StatefulWidget {\n  const RepeatedAnimationBuilderExample3({super.key});\n\n  @override\n  State<RepeatedAnimationBuilderExample3> createState() =>\n      _RepeatedAnimationBuilderExample3State();\n}\n\nclass _RepeatedAnimationBuilderExample3State\n    extends State<RepeatedAnimationBuilderExample3> {\n  // Whether the animation is currently playing. Toggled by the button below.\n  bool play = true;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        RepeatedAnimationBuilder(\n          // Drive play/pause from local state.\n          play: play,\n          start: const Offset(-100, 0),\n          end: const Offset(100, 0),\n          duration: const Duration(seconds: 1),\n          // Provide a different reverse duration to show asymmetric timing.\n          reverseDuration: const Duration(seconds: 5),\n          // Use separate forward/reverse curves.\n          curve: Curves.linear,\n          reverseCurve: Curves.easeInOutCubic,\n          // Ping-pong between start and end, reversing the direction each cycle.\n          mode: LoopingMode.pingPongReverse,\n          builder: (context, value, child) {\n            return Transform.translate(\n              offset: value,\n              child: Container(\n                width: 100,\n                height: 100,\n                color: Colors.red,\n              ),\n            );\n          },\n        ),\n        const Gap(24),\n        PrimaryButton(\n          onPressed: () {\n            setState(() {\n              // Toggle the 'play' flag, which starts/stops the animation.\n              play = !play;\n            });\n          },\n          child: Text(play ? 'Stop' : 'Play'),\n        )\n      ],\n    );\n  }\n}\n",
);

Widget _buildRepeatedAnimationBuilderExample3(BuildContext context) {
  return const RepeatedAnimationBuilderExample3();
}

const List<ComponentExample> repeatedAnimationBuilderExamples = [
  repeatedAnimationBuilderExample1,
  repeatedAnimationBuilderExample2,
  repeatedAnimationBuilderExample3,
];
