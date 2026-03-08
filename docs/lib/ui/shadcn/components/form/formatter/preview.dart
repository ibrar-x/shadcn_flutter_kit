import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../formatter/formatter.dart';

/// FormatterPreview represents a form-related type in the registry.
class FormatterPreview extends StatelessWidget {
  const FormatterPreview({super.key});

  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: TextField(
            decoration: InputDecoration(labelText: 'HEX'),
            inputFormatters: <TextInputFormatter>[
              TextInputFormatters.toUpperCase,
            ],
          ),
        ),
      ),
    );
  }
}
