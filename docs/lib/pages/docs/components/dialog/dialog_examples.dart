import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'dialog_example_1.dart';

const ComponentExample dialogExample1 = ComponentExample(
  title: "Dialog Example",
  builder: _buildDialogExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Dialog with a simple profile edit form.\n///\n/// Opens an [AlertDialog] containing a small form. When the user taps\n/// \"Save changes\", the dialog closes and returns the form values via\n/// [Navigator.pop].\nclass DialogExample1 extends StatelessWidget {\n  const DialogExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return PrimaryButton(\n      onPressed: () {\n        // Present a Material dialog on top of the current route.\n        showDialog(\n          context: context,\n          builder: (context) {\n            final FormController controller = FormController();\n            return AlertDialog(\n              title: const Text('Edit profile'),\n              content: Column(\n                mainAxisSize: MainAxisSize.min,\n                crossAxisAlignment: CrossAxisAlignment.start,\n                children: [\n                  const Text(\n                      'Make changes to your profile here. Click save when you\\'re done'),\n                  const Gap(16),\n                  ConstrainedBox(\n                    constraints: const BoxConstraints(maxWidth: 400),\n                    child: Form(\n                      controller: controller,\n                      child: const FormTableLayout(rows: [\n                        FormField<String>(\n                          key: FormKey(#name),\n                          label: Text('Name'),\n                          child: TextField(\n                            initialValue: 'Thito Yalasatria Sunarya',\n                            autofocus: true,\n                          ),\n                        ),\n                        FormField<String>(\n                          key: FormKey(#username),\n                          label: Text('Username'),\n                          child: TextField(\n                            initialValue: '@sunaryathito',\n                          ),\n                        ),\n                      ]),\n                    ).withPadding(vertical: 16),\n                  ),\n                ],\n              ),\n              actions: [\n                PrimaryButton(\n                  child: const Text('Save changes'),\n                  onPressed: () {\n                    // Return the form values and close the dialog.\n                    Navigator.of(context).pop(controller.values);\n                  },\n                ),\n              ],\n            );\n          },\n        );\n      },\n      child: const Text('Edit Profile'),\n    );\n  }\n}\n",
);

Widget _buildDialogExample1(BuildContext context) {
  return const DialogExample1();
}

const List<ComponentExample> dialogExamples = [
  dialogExample1,
];
