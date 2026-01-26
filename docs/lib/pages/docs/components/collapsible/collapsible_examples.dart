import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'collapsible_example_1.dart';

const ComponentExample collapsibleExample1 = ComponentExample(
  title: "Collapsible Example",
  builder: _buildCollapsibleExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Collapsible list with a trigger and multiple content sections.\n///\n/// The first item is a [CollapsibleTrigger] that toggles visibility of\n/// subsequent [CollapsibleContent] sections.\nclass CollapsibleExample1 extends StatelessWidget {\n  const CollapsibleExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Collapsible(\n      children: [\n        const CollapsibleTrigger(\n          child: Text('@mibrar starred 3 repositories'),\n        ),\n        OutlinedContainer(\n          child: const Text('@ibrar-x/shadcn_flutter_kit')\n              .small()\n              .mono()\n              .withPadding(horizontal: 16, vertical: 8),\n        ).withPadding(top: 8),\n        CollapsibleContent(\n          child: OutlinedContainer(\n            child: const Text('@flutter/flutter')\n                .small()\n                .mono()\n                .withPadding(horizontal: 16, vertical: 8),\n          ).withPadding(top: 8),\n        ),\n        CollapsibleContent(\n          child: OutlinedContainer(\n            child: const Text('@dart-lang/sdk')\n                .small()\n                .mono()\n                .withPadding(horizontal: 16, vertical: 8),\n          ).withPadding(top: 8),\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildCollapsibleExample1(BuildContext context) {
  return const CollapsibleExample1();
}

const List<ComponentExample> collapsibleExamples = [
  collapsibleExample1,
];
