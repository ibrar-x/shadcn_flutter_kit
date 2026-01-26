import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'avatar_group_example_1.dart';

const ComponentExample avatarGroupExample1 = ComponentExample(
  title: "Avatar Group Example 1",
  builder: _buildAvatarGroupExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// AvatarGroup directions demo.\n///\n/// Displays the same set of avatars grouped in four different stacking\n/// directions: left, right, top, and bottom. Useful for dense displays\n/// where overlapping avatars save space.\nclass AvatarGroupExample1 extends StatefulWidget {\n  const AvatarGroupExample1({super.key});\n\n  @override\n  State<AvatarGroupExample1> createState() => _AvatarGroupExample1State();\n}\n\nclass _AvatarGroupExample1State extends State<AvatarGroupExample1> {\n  /// Helper that returns a few colored avatars to visualize overlap.\n  List<AvatarWidget> getAvatars() {\n    return [\n      Avatar(\n        initials: Avatar.getInitials('M Ibrar'),\n        backgroundColor: Colors.red,\n      ),\n      Avatar(\n        initials: Avatar.getInitials('M Ibrar'),\n        backgroundColor: Colors.green,\n      ),\n      Avatar(\n        initials: Avatar.getInitials('M Ibrar'),\n        backgroundColor: Colors.blue,\n      ),\n      Avatar(\n        initials: Avatar.getInitials('M Ibrar'),\n        backgroundColor: Colors.yellow,\n      ),\n    ];\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    return Wrap(\n      spacing: 16,\n      runSpacing: 16,\n      children: [\n        // Overlap avatars towards the left.\n        AvatarGroup.toLeft(children: getAvatars()),\n        // Overlap avatars towards the right.\n        AvatarGroup.toRight(children: getAvatars()),\n        // Stack vertically upwards.\n        AvatarGroup.toTop(children: getAvatars()),\n        // Stack vertically downwards.\n        AvatarGroup.toBottom(children: getAvatars()),\n      ],\n    );\n  }\n}\n",
);

Widget _buildAvatarGroupExample1(BuildContext context) {
  return const AvatarGroupExample1();
}

const List<ComponentExample> avatarGroupExamples = [
  avatarGroupExample1,
];
