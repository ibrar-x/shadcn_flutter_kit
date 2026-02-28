import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../formatter/formatter.dart';

/// FormatterPreview represents a form-related type in the registry.
class FormatterPreview extends StatelessWidget {
  const FormatterPreview({super.key});

  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: TextField(
            decoration: const InputDecoration(labelText: 'HEX'),
            inputFormatters: const <TextInputFormatter>[
              TextInputFormatters.toUpperCase,
            ],
          ),
        ),
      ),
    );
  }
}
