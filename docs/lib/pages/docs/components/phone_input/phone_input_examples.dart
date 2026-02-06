import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'phone_input_example_1.dart';

const ComponentExample phoneInputExample1 = ComponentExample(
  title: "Example",
  builder: _buildPhoneInputExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass PhoneInputExample1 extends StatefulWidget {\n  const PhoneInputExample1({super.key});\n\n  @override\n  State<PhoneInputExample1> createState() => _PhoneInputExample1State();\n}\n\nclass _PhoneInputExample1State extends State<PhoneInputExample1> {\n  PhoneNumber? _phoneNumber;\n  @override\n  Widget build(BuildContext context) {\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        PhoneInput(\n          // Preselect a country; phone parsing/formatting adapt accordingly.\n          initialCountry: Country.indonesia,\n          onChanged: (value) {\n            setState(() {\n              _phoneNumber = value;\n            });\n          },\n        ),\n        const Gap(24),\n        Text(\n          _phoneNumber?.value ?? '(No value)',\n        ),\n      ],\n    );\n  }\n}\n",
);

Widget _buildPhoneInputExample1(BuildContext context) {
  return const PhoneInputExample1();
}

const List<ComponentExample> phoneInputExamples = [
  phoneInputExample1,
];
