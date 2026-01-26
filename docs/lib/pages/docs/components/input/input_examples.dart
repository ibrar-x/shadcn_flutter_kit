import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'input_example_1.dart';
import 'input_example_2.dart';
import 'input_example_3.dart';
import 'input_example_4.dart';
import 'input_example_5.dart';

const ComponentExample inputExample1 = ComponentExample(
  title: "Example",
  builder: _buildInputExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass InputExample1 extends StatelessWidget {\n  const InputExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    // Basic text input using shadcn_flutter's TextField.\n    // placeholder is rendered inside the input when it's empty.\n    return const TextField(\n      placeholder: Text('Enter your name'),\n    );\n  }\n}\n",
);

Widget _buildInputExample1(BuildContext context) {
  return const InputExample1();
}

const ComponentExample inputExample2 = ComponentExample(
  title: "Initial Value Example",
  builder: _buildInputExample2,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass InputExample2 extends StatefulWidget {\n  const InputExample2({super.key});\n\n  @override\n  State<InputExample2> createState() => _InputExample2State();\n}\n\nclass _InputExample2State extends State<InputExample2> {\n  @override\n  Widget build(BuildContext context) {\n    // Demonstrates input features:\n    // - A leading search icon that reacts to the hover state when the field is empty\n    // - A clear button that appears when there's text and the field is focused or hovered\n    return TextField(\n        initialValue: 'Hello World!',\n        placeholder: const Text('Search something...'),\n        features: [\n          // Leading icon only visible when the text is empty\n          InputFeature.leading(StatedWidget.builder(\n            builder: (context, states) {\n              // Use a muted icon normally, switch to the full icon on hover\n              if (states.hovered) {\n                return const Icon(Icons.search);\n              } else {\n                return const Icon(Icons.search).iconMutedForeground();\n              }\n            },\n          ), visibility: InputFeatureVisibility.textEmpty),\n          // Clear button visible when there is text and the field is focused,\n          // or whenever the field is hovered\n          InputFeature.clear(\n            visibility: (InputFeatureVisibility.textNotEmpty &\n                    InputFeatureVisibility.focused) |\n                InputFeatureVisibility.hovered,\n          ),\n        ]);\n  }\n}\n",
);

Widget _buildInputExample2(BuildContext context) {
  return const InputExample2();
}

const ComponentExample inputExample3 = ComponentExample(
  title: "Features Example",
  builder: _buildInputExample3,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass InputExample3 extends StatelessWidget {\n  const InputExample3({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      children: [\n        TextField(\n          placeholder: const Text('Enter your name'),\n          features: [\n            const InputFeature.clear(),\n            // Hint shows a small tooltip-like popup for the input field.\n            InputFeature.hint(\n              popupBuilder: (context) {\n                return const TooltipContainer(\n                    child: Text('This is for your username'));\n              },\n            ),\n            // Convenience actions for copying/pasting directly from the text field UI.\n            const InputFeature.copy(),\n            const InputFeature.paste(),\n          ],\n        ),\n        const Gap(24),\n        const TextField(\n          placeholder: Text('Enter your password'),\n          features: [\n            InputFeature.clear(\n              visibility: InputFeatureVisibility.textNotEmpty,\n            ),\n            // Password toggle configured with `hold` mode: press-and-hold to peek,\n            // release to hide again.\n            InputFeature.passwordToggle(mode: PasswordPeekMode.hold),\n          ],\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildInputExample3(BuildContext context) {
  return const InputExample3();
}

const ComponentExample inputExample4 = ComponentExample(
  title: "Revalidate Form Feature Example",
  builder: _buildInputExample4,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nclass InputExample4 extends StatelessWidget {\n  const InputExample4({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return Form(\n      child: FormField(\n        // Use a stable key for form state lookups and debugging.\n        key: const InputKey(#test),\n        label: const Text('Username'),\n        // Async validator simulating server-side availability check.\n        // Returns `false` (invalid) when the username is taken.\n        validator: ConditionalValidator((value) async {\n          // Simulate a network delay for demonstration purposes\n          await Future.delayed(const Duration(seconds: 1));\n          return !['M Ibrar', 'septogeddon', 'admin'].contains(value);\n        }, message: 'Username already taken'),\n        child: const TextField(\n          placeholder: Text('Enter your username'),\n          initialValue: 'M Ibrar',\n          features: [\n            // Manually triggers the validator again (useful after edits or on demand).\n            InputFeature.revalidate(),\n          ],\n        ),\n      ),\n    );\n  }\n}\n",
);

Widget _buildInputExample4(BuildContext context) {
  return const InputExample4();
}

const ComponentExample inputExample5 = ComponentExample(
  title: "Grouped Inputs Example",
  builder: _buildInputExample5,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// This example demonstrates grouping multiple input fields together\n/// using the `ButtonGroup` component.\n\nclass InputExample5 extends StatelessWidget {\n  const InputExample5({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const Column(\n      mainAxisSize: MainAxisSize.min,\n      spacing: 16,\n      children: [\n        ButtonGroup(children: [\n          // Its important to set width constraints on the TextFields\n          SizedBox(\n            width: 75,\n            child: TextField(placeholder: Text('Red')),\n          ),\n          SizedBox(\n            width: 75,\n            child: TextField(placeholder: Text('Green')),\n          ),\n          SizedBox(\n            width: 75,\n            child: TextField(placeholder: Text('Blue')),\n          ),\n          SizedBox(\n            width: 75,\n            child: TextField(placeholder: Text('Alpha')),\n          ),\n        ]),\n        ButtonGroup.vertical(\n          children: [\n            // Its important to set width constraints on the TextFields\n            SizedBox(\n              width: 200,\n              child: TextField(placeholder: Text('First Name')),\n            ),\n            ButtonGroup.horizontal(\n              children: [\n                SizedBox(\n                  width: 100,\n                  child: TextField(placeholder: Text('Middle Name')),\n                ),\n                SizedBox(\n                  width: 100,\n                  child: TextField(placeholder: Text('Last Name')),\n                ),\n              ],\n            )\n          ],\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildInputExample5(BuildContext context) {
  return const InputExample5();
}

const List<ComponentExample> inputExamples = [
  inputExample1,
  inputExample2,
  inputExample3,
  inputExample4,
  inputExample5,
];
