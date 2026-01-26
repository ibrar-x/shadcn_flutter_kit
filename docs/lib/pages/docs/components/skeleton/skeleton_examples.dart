import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'skeleton_example_1.dart';

const ComponentExample skeletonExample1 = ComponentExample(
  title: "Example",
  builder: _buildSkeletonExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass SkeletonExample1 extends StatelessWidget {\n  const SkeletonExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        const Basic(\n          title: Text('Skeleton Example 1'),\n          content:\n              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),\n          leading: Avatar(\n            initials: '',\n          ),\n          trailing: Icon(Icons.arrow_forward),\n        ),\n        const Gap(24),\n        Basic(\n          title: const Text('Skeleton Example 1'),\n          content: const Text(\n              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),\n          leading: const Avatar(\n            initials: '',\n          ).asSkeleton(),\n          // Note: Avatar and other Image related widget needs its own skeleton\n          trailing: const Icon(Icons.arrow_forward),\n        )\n            // Wrap the whole row in a skeleton to show a loading placeholder for text and icons.\n            .asSkeleton(),\n      ],\n    );\n  }\n}\n",
);

Widget _buildSkeletonExample1(BuildContext context) {
  return const SkeletonExample1();
}

const List<ComponentExample> skeletonExamples = [
  skeletonExample1,
];
