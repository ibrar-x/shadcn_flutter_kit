import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'timeline_example_1.dart';

const ComponentExample timelineExample1 = ComponentExample(
  title: "Timeline Example",
  builder: _buildTimelineExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n// Demonstrates a static Timeline with entries showing time, title, and content.\n\nclass TimelineExample1 extends StatelessWidget {\n  const TimelineExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Timeline(\n      // Each TimelineData item renders a time, title, and detailed content.\n      // Styling/layout comes from the Timeline widget; content is plain widgets.\n      data: [\n        TimelineData(\n          time: const Text('2022-01-01'),\n          title: const Text('First event'),\n          content: const Text(\n              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Odio euismod lacinia at quis risus sed vulputate odio ut. Quam viverra orci sagittis eu volutpat odio facilisis mauris.'),\n        ),\n        TimelineData(\n          time: const Text('2022-01-02'),\n          title: const Text('Second event'),\n          content: const Text(\n              'Aut eius excepturi ex recusandae eius est minima molestiae. Nam dolores iusto ad fugit reprehenderit hic dolorem quisquam et quia omnis non suscipit nihil sit libero distinctio. Ad dolorem tempora sit nostrum voluptatem qui tempora unde? Sit rerum magnam nam ipsam nesciunt aut rerum necessitatibus est quia esse non magni quae.'),\n        ),\n        TimelineData(\n          time: const Text('2022-01-03'),\n          title: const Text('Third event'),\n          content: const Text(\n            'Sit culpa quas ex nulla animi qui deleniti minus rem placeat mollitia. Et enim doloremque et quia sequi ea dolores voluptatem ea rerum vitae. Aut itaque incidunt est aperiam vero sit explicabo fuga id optio quis et molestiae nulla ex quae quam. Ab eius dolores ab tempora dolorum eos beatae soluta At ullam placeat est incidunt cumque.',\n          ),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildTimelineExample1(BuildContext context) {
  return const TimelineExample1();
}

const List<ComponentExample> timelineExamples = [
  timelineExample1,
];
