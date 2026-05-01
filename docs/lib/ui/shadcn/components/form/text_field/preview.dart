import 'package:flutter/material.dart' hide TextField;

import '../text_field/text_field.dart';

/// TextFieldPreview represents a form-related type in the registry.
class TextFieldPreview extends StatelessWidget {
  const TextFieldPreview({super.key});

  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TextField(placeholder: Text('Enter your name')),
              SizedBox(height: 16),
              TextField(
                placeholder: Text('Search...'),
                features: [InputFeature.clear()],
              ),
              SizedBox(height: 16),
              TextField(
                placeholder: Text('Password'),
                obscureText: true,
                features: [InputFeature.passwordToggle(), InputFeature.clear()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
