import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'progress_example_1.dart';

const ComponentExample progressExample1 = ComponentExample(
  title: "Progress Example",
  builder: _buildProgressExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass ProgressExample1 extends StatefulWidget {\n  const ProgressExample1({super.key});\n\n  @override\n  State<ProgressExample1> createState() => _ProgressExample1State();\n}\n\nclass _ProgressExample1State extends State<ProgressExample1> {\n  // Track the current progress value as a percentage (0\u2013100).\n  // This is a controlled example: UI buttons below update this state.\n  double _progress = 0.0;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        // Constrain the progress bar width so it doesn't grow to the full page width in docs.\n        SizedBox(\n          width: 400,\n          child: Progress(\n            // Clamp the provided value so the widget never receives out-of-range input.\n            // Alternatively, you can ensure only 0\u2013100 values are set in state.\n            progress: _progress.clamp(0, 100),\n            // The logical domain for the progress value. Values outside will be coerced by clamp above.\n            min: 0,\n            max: 100,\n          ),\n        ),\n        const Gap(16),\n        // Simple controls to demonstrate changing progress.\n        Row(\n          children: [\n            DestructiveButton(\n              onPressed: () {\n                setState(() {\n                  // Reset back to 0%.\n                  _progress = 0;\n                });\n              },\n              child: const Text('Reset'),\n            ),\n            const Gap(16),\n            PrimaryButton(\n              onPressed: () {\n                // Defensive check so we don't go below 0.\n                if (_progress > 0) {\n                  setState(() {\n                    // Decrease by a fixed step.\n                    _progress -= 10;\n                  });\n                }\n              },\n              child: const Text('Decrease by 10'),\n            ),\n            const Gap(16),\n            PrimaryButton(\n              onPressed: () {\n                // Defensive check so we don't go above 100.\n                if (_progress < 100) {\n                  setState(() {\n                    // Increase by a fixed step.\n                    _progress += 10;\n                  });\n                }\n              },\n              child: const Text('Increase by 10'),\n            ),\n          ],\n        )\n      ],\n    );\n  }\n}\n",
);

Widget _buildProgressExample1(BuildContext context) {
  return const ProgressExample1();
}

const List<ComponentExample> progressExamples = [
  progressExample1,
];
