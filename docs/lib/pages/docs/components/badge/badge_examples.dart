import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'badge_example_1.dart';
import 'badge_example_2.dart';
import 'badge_example_3.dart';
import 'badge_example_4.dart';

const ComponentExample badgeExample1 = ComponentExample(
  title: "Primary Badge Example",
  builder: _buildBadgeExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Primary badge style.\n///\n/// Badges are small, attention-grabbing labels. Use `PrimaryBadge` for the\n/// default emphasis.\nclass BadgeExample1 extends StatelessWidget {\n  const BadgeExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const PrimaryBadge(\n      child: Text('Primary'),\n    );\n  }\n}\n",
);

Widget _buildBadgeExample1(BuildContext context) {
  return const BadgeExample1();
}

const ComponentExample badgeExample2 = ComponentExample(
  title: "Secondary Badge Example",
  builder: _buildBadgeExample2,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Secondary badge style.\n///\n/// Use `SecondaryBadge` for a lighter emphasis compared to primary.\nclass BadgeExample2 extends StatelessWidget {\n  const BadgeExample2({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const SecondaryBadge(\n      child: Text('Secondary'),\n    );\n  }\n}\n",
);

Widget _buildBadgeExample2(BuildContext context) {
  return const BadgeExample2();
}

const ComponentExample badgeExample3 = ComponentExample(
  title: "Outline Badge Example",
  builder: _buildBadgeExample3,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Outline badge style.\n///\n/// Outlined appearance for a more subtle badge.\nclass BadgeExample3 extends StatelessWidget {\n  const BadgeExample3({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const OutlineBadge(\n      child: Text('Outline'),\n    );\n  }\n}\n",
);

Widget _buildBadgeExample3(BuildContext context) {
  return const BadgeExample3();
}

const ComponentExample badgeExample4 = ComponentExample(
  title: "Destructive Badge Example",
  builder: _buildBadgeExample4,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Destructive badge style.\n///\n/// Use `DestructiveBadge` to call attention to critical or dangerous states.\nclass BadgeExample4 extends StatelessWidget {\n  const BadgeExample4({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const DestructiveBadge(\n      child: Text('Destructive'),\n    );\n  }\n}\n",
);

Widget _buildBadgeExample4(BuildContext context) {
  return const BadgeExample4();
}

const List<ComponentExample> badgeExamples = [
  badgeExample1,
  badgeExample2,
  badgeExample3,
  badgeExample4,
];
