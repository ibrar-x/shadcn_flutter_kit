import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'form_example_1.dart';
import 'form_example_2.dart';
import 'form_example_3.dart';

const ComponentExample formExample1 = ComponentExample(
  title: "Form Example (Table Layout)",
  builder: _buildFormExample1,
  code:
      "import 'dart:convert';\n\nimport 'package:docs/shadcn_ui.dart';\n\nclass FormExample1 extends StatefulWidget {\n  const FormExample1({super.key});\n\n  @override\n  State<FormExample1> createState() => _FormExample1State();\n}\n\nclass _FormExample1State extends State<FormExample1> {\n  final _usernameKey = const TextFieldKey('username');\n  final _passwordKey = const TextFieldKey('password');\n  final _confirmPasswordKey = const TextFieldKey('confirmPassword');\n  @override\n  Widget build(BuildContext context) {\n    return SizedBox(\n      width: 480,\n      child: Form(\n        // Submit handler receives a typed map of field keys to values.\n        onSubmit: (context, values) {\n          // Get the values individually\n          String? username = _usernameKey[values];\n          String? password = _passwordKey[values];\n          String? confirmPassword = _confirmPasswordKey[values];\n          // or just encode the whole map to JSON directly\n          String json = jsonEncode(values.map((key, value) {\n            return MapEntry(key.key, value);\n          }));\n          showDialog(\n            context: context,\n            builder: (context) {\n              return AlertDialog(\n                title: const Text('Form Values'),\n                content: Column(\n                  mainAxisSize: MainAxisSize.min,\n                  crossAxisAlignment: CrossAxisAlignment.start,\n                  children: [\n                    Text('Username: \$username'),\n                    Text('Password: \$password'),\n                    Text('Confirm Password: \$confirmPassword'),\n                    Text('JSON: \$json'),\n                  ],\n                ),\n                actions: [\n                  PrimaryButton(\n                    onPressed: () => Navigator.of(context).pop(),\n                    child: const Text('Close'),\n                  ),\n                ],\n              );\n            },\n          );\n        },\n        child: Column(\n          mainAxisSize: MainAxisSize.min,\n          crossAxisAlignment: CrossAxisAlignment.end,\n          children: [\n            FormTableLayout(\n              rows: [\n                FormField(\n                  key: _usernameKey,\n                  label: const Text('Username'),\n                  hint: const Text('This is your public display name'),\n                  validator: const LengthValidator(min: 4),\n                  child: const TextField(\n                    initialValue: 'M Ibrar',\n                  ),\n                ),\n                FormField(\n                  key: _passwordKey,\n                  label: const Text('Password'),\n                  validator: const LengthValidator(min: 8),\n                  child: const TextField(\n                    obscureText: true,\n                  ),\n                ),\n                FormField(\n                  key: _confirmPasswordKey,\n                  label: const Text('Confirm Password'),\n                  validator: CompareWith.equal(_passwordKey,\n                      message: 'Passwords do not match'),\n                  child: const TextField(\n                    obscureText: true,\n                  ),\n                ),\n              ],\n            ),\n            const Gap(24),\n            FormErrorBuilder(\n              builder: (context, errors, child) {\n                // Disable the submit button while there are validation errors.\n                return PrimaryButton(\n                  onPressed: errors.isEmpty ? () => context.submitForm() : null,\n                  child: const Text('Submit'),\n                );\n              },\n            )\n          ],\n        ),\n      ),\n    );\n  }\n}\n",
);

Widget _buildFormExample1(BuildContext context) {
  return const FormExample1();
}

const ComponentExample formExample2 = ComponentExample(
  title: "Form Example (Column Layout)",
  builder: _buildFormExample2,
  code: r"""import 'dart:convert';

import 'package:docs/shadcn_ui.dart';
import 'package:flutter/material.dart' show showDialog;

class FormExample2 extends StatefulWidget {
  const FormExample2({super.key});

  @override
  State<FormExample2> createState() => _FormExample2State();
}

class _FormExample2State extends State<FormExample2> {
  static const _searchKey = TextFieldKey(#search);
  static const _nameKey = TextFieldKey(#name);
  static const _emailKey = TextFieldKey(#email);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Form(
        onSubmit: (context, values) {
          final String json = jsonEncode(values.map((key, value) {
            return MapEntry(key.key, value);
          }));

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Form Values'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${_nameKey[values]}'),
                    Text('Email: ${_emailKey[values]}'),
                    Text('JSON: $json'),
                  ],
                ),
                actions: [
                  PrimaryButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Gap(16),
            FormTableLayout(
              rows: [
                const FormField<String>(
                  key: _searchKey,
                  label: Text('Search (ignored)'),
                  child: IgnoreForm(
                    child: TextField(
                      placeholder: Text('Type to search...'),
                    ),
                  ),
                ),
                const FormField<String>(
                  key: _nameKey,
                  label: Text('Name'),
                  validator: LengthValidator(min: 4),
                  showErrors: {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(),
                ),
                FormField<String>(
                  key: _emailKey,
                  label: const Text('Email'),
                  validator: const EmailValidator() & const NotEmptyValidator(),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: const TextField(),
                ),
              ],
            ),
            const Gap(24),
            const SubmitButton(child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
""",
);

Widget _buildFormExample2(BuildContext context) {
  return const FormExample2();
}

const ComponentExample formExample3 = ComponentExample(
  title: "Validation Mode Example",
  builder: _buildFormExample3,
  code:
      "import 'dart:convert';\n\nimport 'package:docs/shadcn_ui.dart';\n\nclass FormExample3 extends StatefulWidget {\n  const FormExample3({super.key});\n\n  @override\n  State<FormExample3> createState() => _FormExample3State();\n}\n\nclass _FormExample3State extends State<FormExample3> {\n  final _dummyData = [\n    'M Ibrar',\n    'septogeddon',\n    'shadcn',\n  ];\n\n  final _usernameKey = const TextFieldKey('username');\n  final _passwordKey = const TextFieldKey('password');\n  final _confirmPasswordKey = const TextFieldKey('confirmPassword');\n  @override\n  Widget build(BuildContext context) {\n    return SizedBox(\n      width: 480,\n      child: Form(\n        onSubmit: (context, values) {\n          showDialog(\n            context: context,\n            builder: (context) {\n              return AlertDialog(\n                title: const Text('Form Values'),\n                content: Text(jsonEncode(values.map(\n                  (key, value) {\n                    return MapEntry(key.key, value);\n                  },\n                ))),\n                actions: [\n                  PrimaryButton(\n                    onPressed: () => Navigator.of(context).pop(),\n                    child: const Text('Close'),\n                  ),\n                ],\n              );\n            },\n          );\n        },\n        child: Column(\n          mainAxisSize: MainAxisSize.min,\n          crossAxisAlignment: CrossAxisAlignment.end,\n          children: [\n            FormTableLayout(\n              rows: [\n                FormField(\n                  key: _usernameKey,\n                  label: const Text('Username'),\n                  hint: const Text('This is your public display name'),\n                  // Combine validators: length + async availability check,\n                  // but only run the async validator on submit.\n                  validator: const LengthValidator(min: 4) &\n                      ValidationMode(\n                        ConditionalValidator((value) async {\n                          // simulate a network delay for example purpose\n                          await Future.delayed(const Duration(seconds: 1));\n                          return !_dummyData.contains(value);\n                        }, message: 'Username already taken'),\n                        // only validate when the form is submitted\n                        mode: {FormValidationMode.submitted},\n                      ),\n                  child: const TextField(\n                    initialValue: 'M Ibrar',\n                  ),\n                ),\n                FormField(\n                  key: _passwordKey,\n                  label: const Text('Password'),\n                  validator: const LengthValidator(min: 8),\n                  showErrors: const {\n                    FormValidationMode.submitted,\n                    FormValidationMode.changed\n                  },\n                  child: const TextField(\n                    obscureText: true,\n                  ),\n                ),\n                FormField<String>(\n                  key: _confirmPasswordKey,\n                  label: const Text('Confirm Password'),\n                  showErrors: const {\n                    FormValidationMode.submitted,\n                    FormValidationMode.changed\n                  },\n                  validator: CompareWith.equal(_passwordKey,\n                      message: 'Passwords do not match'),\n                  child: const TextField(\n                    obscureText: true,\n                  ),\n                ),\n              ],\n            ),\n            const Gap(24),\n            const SubmitButton(\n              loadingTrailing: AspectRatio(\n                aspectRatio: 1,\n                child: CircularProgressIndicator(\n                  onSurface: true,\n                ),\n              ),\n              child: Text('Register'),\n            ),\n          ],\n        ),\n      ),\n    );\n  }\n}\n",
);

Widget _buildFormExample3(BuildContext context) {
  return const FormExample3();
}

const List<ComponentExample> formExamples = [
  formExample1,
  formExample2,
  formExample3,
];
