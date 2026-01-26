import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'overflow_marquee_example_1.dart';

const ComponentExample overflowMarqueeExample1 = ComponentExample(
  title: "Example",
  builder: _buildOverflowMarqueeExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass OverflowMarqueeExample1 extends StatelessWidget {\n  const OverflowMarqueeExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const SizedBox(\n      width: 200,\n      child: OverflowMarquee(\n        // When the text exceeds the available width, it smoothly scrolls horizontally.\n        child: Text(\n          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',\n        ),\n      ),\n    );\n  }\n}\n",
);

Widget _buildOverflowMarqueeExample1(BuildContext context) {
  return const OverflowMarqueeExample1();
}

const List<ComponentExample> overflowMarqueeExamples = [
  overflowMarqueeExample1,
];
