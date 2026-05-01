import 'package:docs/shadcn_ui.dart';
import 'package:flutter/material.dart' show showDialog;
import 'dart:convert';

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
