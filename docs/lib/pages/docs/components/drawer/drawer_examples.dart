import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'drawer_example_1.dart';

const ComponentExample drawerExample1 = ComponentExample(
  title: "Example",
  builder: _buildDrawerExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Drawer overlay opened from different screen edges.\n///\n/// Repeatedly opens nested drawers cycling through positions to showcase\n/// [openDrawer] and how to close using [closeOverlay].\nclass DrawerExample1 extends StatefulWidget {\n  const DrawerExample1({super.key});\n\n  @override\n  State<DrawerExample1> createState() => _DrawerExample1State();\n}\n\nclass _DrawerExample1State extends State<DrawerExample1> {\n  // Sequence of positions to cycle through as drawers are stacked.\n  List<OverlayPosition> positions = [\n    OverlayPosition.end,\n    OverlayPosition.end,\n    OverlayPosition.bottom,\n    OverlayPosition.bottom,\n    OverlayPosition.top,\n    OverlayPosition.top,\n    OverlayPosition.start,\n    OverlayPosition.start,\n  ];\n  // Open a drawer and optionally open another from within it.\n  void open(BuildContext context, int count) {\n    openDrawer(\n      context: context,\n      expands: true,\n      builder: (context) {\n        return Container(\n          padding: const EdgeInsets.all(48),\n          child: IntrinsicWidth(\n            child: Column(\n              mainAxisSize: MainAxisSize.min,\n              crossAxisAlignment: CrossAxisAlignment.stretch,\n              children: [\n                Text(\n                    'Drawer \${count + 1} at \${positions[count % positions.length].name}'),\n                const Gap(16),\n                PrimaryButton(\n                  onPressed: () {\n                    // Open another drawer on top.\n                    open(context, count + 1);\n                  },\n                  child: const Text('Open Another Drawer'),\n                ),\n                const Gap(8),\n                SecondaryButton(\n                  onPressed: () {\n                    // Close the current top-most overlay.\n                    closeOverlay(context);\n                  },\n                  child: const Text('Close Drawer'),\n                ),\n              ],\n            ),\n          ),\n        );\n      },\n      position: positions[count % positions.length],\n    );\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    return PrimaryButton(\n      onPressed: () {\n        open(context, 0);\n      },\n      child: const Text('Open Drawer'),\n    );\n  }\n}\n",
);

Widget _buildDrawerExample1(BuildContext context) {
  return const DrawerExample1();
}

const List<ComponentExample> drawerExamples = [
  drawerExample1,
];