import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'hover_card_example_1.dart';

const ComponentExample hoverCardExample1 = ComponentExample(
  title: "Example",
  builder: _buildHoverCardExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass HoverCardExample1 extends StatelessWidget {\n  const HoverCardExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    // HoverCard shows a floating panel when the user hovers over the child.\n    // - hoverBuilder builds the content of the floating card.\n    // - child is the anchor widget users point at/hover to reveal the card.\n    return HoverCard(\n      hoverBuilder: (context) {\n        // SurfaceCard provides an elevated container with default padding and\n        // surface styling. We constrain the width so the text wraps nicely.\n        return const SurfaceCard(\n          child: Basic(\n            leading: FlutterLogo(),\n            title: Text('@flutter'),\n            content: Text(\n                'The Flutter SDK provides the tools to build beautiful apps for mobile, web, and desktop from a single codebase.'),\n          ),\n        ).sized(width: 300);\n      },\n      child: LinkButton(\n        // The LinkButton acts as the hover target. onPressed is provided for\n        // completeness but not used in this example.\n        onPressed: () {},\n        child: const Text('@flutter'),\n      ),\n    );\n  }\n}\n",
);

Widget _buildHoverCardExample1(BuildContext context) {
  return const HoverCardExample1();
}

const List<ComponentExample> hoverCardExamples = [
  hoverCardExample1,
];
