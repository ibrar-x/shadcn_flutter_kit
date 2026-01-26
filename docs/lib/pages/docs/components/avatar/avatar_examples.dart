import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'avatar_example_1.dart';
import 'avatar_example_2.dart';
import 'avatar_example_3.dart';

const ComponentExample avatarExample1 = ComponentExample(
  title: "Avatar Example",
  builder: _buildAvatarExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Avatar with image and initials fallback.\n///\n/// If the image fails to load, the [initials] will be shown over the\n/// [backgroundColor]. This example uses a remote GitHub avatar URL.\nclass AvatarExample1 extends StatelessWidget {\n  const AvatarExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Avatar(\n      backgroundColor: Colors.red,\n      // Helper to derive initials from a username or full name.\n      initials: Avatar.getInitials('M Ibrar'),\n      provider: const NetworkImage(\n          'https://avatars.githubusercontent.com/u/64018564?v=4'),\n    );\n  }\n}\n",
);

Widget _buildAvatarExample1(BuildContext context) {
  return const AvatarExample1();
}

const ComponentExample avatarExample2 = ComponentExample(
  title: "Avatar Example with Username Initials",
  builder: _buildAvatarExample2,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Simple Avatar with initials only.\n///\n/// Demonstrates customizing the avatar [size] while displaying\n/// just the text initials (no image provider).\nclass AvatarExample2 extends StatelessWidget {\n  const AvatarExample2({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Avatar(\n      // Use initials when you don't have an image.\n      initials: Avatar.getInitials('M Ibrar'),\n      size: 64,\n    );\n  }\n}\n",
);

Widget _buildAvatarExample2(BuildContext context) {
  return const AvatarExample2();
}

const ComponentExample avatarExample3 = ComponentExample(
  title: "Avatar Example with Badge",
  builder: _buildAvatarExample3,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Avatar with a status badge.\n///\n/// Shows how to attach an [AvatarBadge] to indicate presence/status\n/// (e.g., online/offline) or any small highlight.\nclass AvatarExample3 extends StatelessWidget {\n  const AvatarExample3({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Avatar(\n      initials: Avatar.getInitials('M Ibrar'),\n      size: 64,\n      badge: const AvatarBadge(\n        size: 20,\n        color: Colors.green,\n      ),\n    );\n  }\n}\n",
);

Widget _buildAvatarExample3(BuildContext context) {
  return const AvatarExample3();
}

const List<ComponentExample> avatarExamples = [
  avatarExample1,
  avatarExample2,
  avatarExample3,
];
