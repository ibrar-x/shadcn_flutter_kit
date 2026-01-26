import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'window_example_1.dart';

const ComponentExample windowExample1 = ComponentExample(
  title: "Window Example",
  builder: _buildWindowExample1,
  code: "import 'package:docs/debug.dart';\nimport 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n// Demonstrates a WindowNavigator simulating multiple desktop-style windows,\n// with an action to add a new window at runtime.\n\nclass WindowExample1 extends StatefulWidget {\n  const WindowExample1({super.key});\n\n  @override\n  State<WindowExample1> createState() => _WindowExample1State();\n}\n\nclass _WindowExample1State extends State<WindowExample1> {\n  final GlobalKey<WindowNavigatorHandle> navigatorKey = GlobalKey();\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      crossAxisAlignment: CrossAxisAlignment.stretch,\n      children: [\n        OutlinedContainer(\n          height: 600, // for example purpose\n          child: WindowNavigator(\n            key: navigatorKey,\n            // Pre-populate with two windows, each with its own bounds and title.\n            initialWindows: [\n              Window(\n                bounds: const Rect.fromLTWH(0, 0, 200, 200),\n                title: const Text('Window 1'),\n                content: const RebuildCounter(),\n              ),\n              Window(\n                bounds: const Rect.fromLTWH(200, 0, 200, 200),\n                title: const Text('Window 2'),\n                content: const RebuildCounter(),\n              ),\n            ],\n            child: const Center(\n              child: Text('Desktop'),\n            ),\n          ),\n        ),\n        PrimaryButton(\n          child: const Text('Add Window'),\n          onPressed: () {\n            // Push a new window via the navigator; title uses the current count.\n            navigatorKey.currentState?.pushWindow(\n              Window(\n                bounds: const Rect.fromLTWH(0, 0, 200, 200),\n                title: Text(\n                    'Window \${navigatorKey.currentState!.windows.length + 1}'),\n                content: const RebuildCounter(),\n              ),\n            );\n          },\n        )\n      ],\n    );\n  }\n}\n",
);

Widget _buildWindowExample1(BuildContext context) {
  return const WindowExample1();
}

const List<ComponentExample> windowExamples = [
  windowExample1,
];