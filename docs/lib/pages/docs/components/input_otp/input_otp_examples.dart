import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'input_otp_example_1.dart';
import 'input_otp_example_2.dart';
import 'input_otp_example_3.dart';
import 'input_otp_example_4.dart';

const ComponentExample inputOtpExample1 = ComponentExample(
  title: "Example",
  builder: _buildInputOtpExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass InputOTPExample1 extends StatefulWidget {\n  const InputOTPExample1({super.key});\n\n  @override\n  State<InputOTPExample1> createState() => _InputOTPExample1State();\n}\n\nclass _InputOTPExample1State extends State<InputOTPExample1> {\n  String value = '';\n  String? submittedValue;\n  @override\n  Widget build(BuildContext context) {\n    // Basic OTP input with onChanged and onSubmitted callbacks.\n    // The example groups 3 digits, a visual separator, then 3 more digits.\n    return Column(\n      mainAxisSize: MainAxisSize.min,\n      children: [\n        InputOTP(\n          onChanged: (value) {\n            setState(() {\n              this.value = value.otpToString();\n            });\n          },\n          onSubmitted: (value) {\n            setState(() {\n              submittedValue = value.otpToString();\n            });\n          },\n          children: [\n            // Each character cell allows digits. The separator is a visual divider only.\n            InputOTPChild.character(allowDigit: true),\n            InputOTPChild.character(allowDigit: true),\n            InputOTPChild.character(allowDigit: true),\n            InputOTPChild.separator,\n            InputOTPChild.character(allowDigit: true),\n            InputOTPChild.character(allowDigit: true),\n            InputOTPChild.character(allowDigit: true),\n          ],\n        ),\n        gap(16),\n        Text('Value: \$value'),\n        Text('Submitted Value: \$submittedValue'),\n      ],\n    );\n  }\n}\n",
);

Widget _buildInputOtpExample1(BuildContext context) {
  return const InputOTPExample1();
}

const ComponentExample inputOtpExample2 = ComponentExample(
  title: "Initial Value Example",
  builder: _buildInputOtpExample2,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass InputOTPExample2 extends StatelessWidget {\n  const InputOTPExample2({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    // Pre-populate the first group using the characters from the string '123'.\n    // InputOTP takes a list of code units for its initial value.\n    return InputOTP(\n      initialValue: '123'.codeUnits,\n      children: [\n        InputOTPChild.character(allowDigit: true),\n        InputOTPChild.character(allowDigit: true),\n        InputOTPChild.character(allowDigit: true),\n        InputOTPChild.separator,\n        InputOTPChild.character(allowDigit: true),\n        InputOTPChild.character(allowDigit: true),\n        InputOTPChild.character(allowDigit: true),\n      ],\n    );\n  }\n}\n",
);

Widget _buildInputOtpExample2(BuildContext context) {
  return const InputOTPExample2();
}

const ComponentExample inputOtpExample3 = ComponentExample(
  title: "Obscured Example",
  builder: _buildInputOtpExample3,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass InputOTPExample3 extends StatelessWidget {\n  const InputOTPExample3({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    // Same layout as before but with obscured input to hide the characters\n    // (useful for sensitive OTP codes).\n    return InputOTP(\n      children: [\n        InputOTPChild.character(allowDigit: true, obscured: true),\n        InputOTPChild.character(allowDigit: true, obscured: true),\n        InputOTPChild.character(allowDigit: true, obscured: true),\n        InputOTPChild.separator,\n        InputOTPChild.character(allowDigit: true, obscured: true),\n        InputOTPChild.character(allowDigit: true, obscured: true),\n        InputOTPChild.character(allowDigit: true, obscured: true),\n      ],\n    );\n  }\n}\n",
);

Widget _buildInputOtpExample3(BuildContext context) {
  return const InputOTPExample3();
}

const ComponentExample inputOtpExample4 = ComponentExample(
  title: "Upper Case Alphabet Example",
  builder: _buildInputOtpExample4,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass InputOTPExample4 extends StatelessWidget {\n  const InputOTPExample4({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    // OTP comprised of uppercase alphabet characters only, split into\n    // multiple groups with separators. Each InputOTPChild.character controls\n    // what kinds of characters are permitted.\n    return InputOTP(\n      children: [\n        InputOTPChild.character(\n            allowLowercaseAlphabet: true,\n            allowUppercaseAlphabet: true,\n            onlyUppercaseAlphabet: true),\n        InputOTPChild.character(\n            allowLowercaseAlphabet: true,\n            allowUppercaseAlphabet: true,\n            onlyUppercaseAlphabet: true),\n        InputOTPChild.character(\n            allowLowercaseAlphabet: true,\n            allowUppercaseAlphabet: true,\n            onlyUppercaseAlphabet: true),\n        InputOTPChild.separator,\n        InputOTPChild.character(\n            allowLowercaseAlphabet: true,\n            allowUppercaseAlphabet: true,\n            onlyUppercaseAlphabet: true),\n        InputOTPChild.character(\n            allowLowercaseAlphabet: true,\n            allowUppercaseAlphabet: true,\n            onlyUppercaseAlphabet: true),\n        InputOTPChild.character(\n            allowLowercaseAlphabet: true,\n            allowUppercaseAlphabet: true,\n            onlyUppercaseAlphabet: true),\n        InputOTPChild.separator,\n        InputOTPChild.character(\n            allowLowercaseAlphabet: true,\n            allowUppercaseAlphabet: true,\n            onlyUppercaseAlphabet: true),\n        InputOTPChild.character(\n            allowLowercaseAlphabet: true,\n            allowUppercaseAlphabet: true,\n            onlyUppercaseAlphabet: true),\n        InputOTPChild.character(\n            allowLowercaseAlphabet: true,\n            allowUppercaseAlphabet: true,\n            onlyUppercaseAlphabet: true),\n      ],\n    );\n  }\n}\n",
);

Widget _buildInputOtpExample4(BuildContext context) {
  return const InputOTPExample4();
}

const List<ComponentExample> inputOtpExamples = [
  inputOtpExample1,
  inputOtpExample2,
  inputOtpExample3,
  inputOtpExample4,
];