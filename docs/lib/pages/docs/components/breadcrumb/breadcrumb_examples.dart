import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'breadcrumb_example_1.dart';

const ComponentExample breadcrumbExample1 = ComponentExample(
  title: "Breadcrumb Example",
  builder: _buildBreadcrumbExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Breadcrumb with arrow separators.\n///\n/// Demonstrates how to compose a [Breadcrumb] from a series of items,\n/// mixing interactive [TextButton]s and static labels. The `separator`\n/// controls the visual delimiter between items.\nclass BreadcrumbExample1 extends StatelessWidget {\n  const BreadcrumbExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Breadcrumb(\n      // Use a built-in arrow separator for a conventional look.\n      separator: Breadcrumb.arrowSeparator,\n      children: [\n        TextButton(\n          onPressed: () {},\n          density: ButtonDensity.compact,\n          child: const Text('Home'),\n        ),\n        const MoreDots(),\n        TextButton(\n          onPressed: () {},\n          density: ButtonDensity.compact,\n          child: const Text('Components'),\n        ),\n        // Final segment as a non-interactive label.\n        const Text('Breadcrumb'),\n      ],\n    );\n  }\n}\n",
);

Widget _buildBreadcrumbExample1(BuildContext context) {
  return const BreadcrumbExample1();
}

const List<ComponentExample> breadcrumbExamples = [
  breadcrumbExample1,
];
