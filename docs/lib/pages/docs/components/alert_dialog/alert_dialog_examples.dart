import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'alert_dialog_example_1.dart';

const ComponentExample alertDialogExample1 = ComponentExample(
  title: "Alert Dialog Example",
  builder: _buildAlertDialogExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// AlertDialog demo with a trigger button.\n///\n/// Tapping the [PrimaryButton] opens a Material [showDialog] that\n/// contains an [AlertDialog] with a title, content, and action buttons.\n/// The actions simply dismiss the dialog using [Navigator.pop].\nclass AlertDialogExample1 extends StatelessWidget {\n  const AlertDialogExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return PrimaryButton(\n      child: const Text('Click Here'),\n      onPressed: () {\n        // Standard Flutter API to present a dialog above the current route.\n        showDialog(\n          context: context,\n          builder: (context) {\n            return AlertDialog(\n              title: const Text('Alert title'),\n              content: const Text(\n                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),\n              actions: [\n                // Secondary action to cancel/dismiss.\n                OutlineButton(\n                  child: const Text('Cancel'),\n                  onPressed: () {\n                    // Close the dialog.\n                    Navigator.pop(context);\n                  },\n                ),\n                // Primary action to accept/confirm.\n                PrimaryButton(\n                  child: const Text('OK'),\n                  onPressed: () {\n                    // Close the dialog. In real apps, perform work before closing.\n                    Navigator.pop(context);\n                  },\n                ),\n              ],\n            );\n          },\n        );\n      },\n    );\n  }\n}\n",
);

Widget _buildAlertDialogExample1(BuildContext context) {
  return const AlertDialogExample1();
}

const List<ComponentExample> alertDialogExamples = [
  alertDialogExample1,
];
