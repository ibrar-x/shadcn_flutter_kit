import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'checkbox_example_1.dart';
import 'checkbox_example_2.dart';

const ComponentExample checkboxExample1 = ComponentExample(
  title: "Checkbox Example",
  builder: _buildCheckboxExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Checkbox with two states (checked/unchecked).\n///\n/// Demonstrates controlling [Checkbox] via a local [CheckboxState]\n/// and updating it from [onChanged].\nclass CheckboxExample1 extends StatefulWidget {\n  const CheckboxExample1({super.key});\n\n  @override\n  State<CheckboxExample1> createState() => _CheckboxExample1State();\n}\n\nclass _CheckboxExample1State extends State<CheckboxExample1> {\n  // Start unchecked; toggle when the user taps the control.\n  CheckboxState _state = CheckboxState.unchecked;\n  @override\n  Widget build(BuildContext context) {\n    return Checkbox(\n      state: _state,\n      onChanged: (value) {\n        setState(() {\n          _state = value;\n        });\n      },\n      // Optional label placed on the trailing side.\n      trailing: const Text('Remember me'),\n    );\n  }\n}\n",
);

Widget _buildCheckboxExample1(BuildContext context) {
  return const CheckboxExample1();
}

const ComponentExample checkboxExample2 = ComponentExample(
  title: "Checkbox Example with Tristate",
  builder: _buildCheckboxExample2,
  code: "import 'package:docs/shadcn_ui.dart';\n\n/// Checkbox with three states (unchecked, indeterminate, checked).\n///\n/// Enabling [tristate] allows the middle \"indeterminate\" state.\nclass CheckboxExample2 extends StatefulWidget {\n  const CheckboxExample2({super.key});\n\n  @override\n  State<CheckboxExample2> createState() => _CheckboxExample2State();\n}\n\nclass _CheckboxExample2State extends State<CheckboxExample2> {\n  CheckboxState _state = CheckboxState.unchecked;\n  @override\n  Widget build(BuildContext context) {\n    return Checkbox(\n      state: _state,\n      onChanged: (value) {\n        setState(() {\n          _state = value;\n        });\n      },\n      trailing: const Text('Remember me'),\n      // Allow toggling: unchecked -> indeterminate -> checked -> ...\n      tristate: true,\n    );\n  }\n}\n",
);

Widget _buildCheckboxExample2(BuildContext context) {
  return const CheckboxExample2();
}

const List<ComponentExample> checkboxExamples = [
  checkboxExample1,
  checkboxExample2,
];
