import 'package:flutter/material.dart' hide TextField;

import '../input/input.dart' as input;
import '../text_field/text_field.dart' as shadcn;

/// InputPreview renders form UI and wires input behavior.
class InputPreview extends StatelessWidget {
  const InputPreview({super.key});

  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: shadcn.TextField(
            controller: TextEditingController(text: 'hello@shadcn.dev'),
            placeholder: const Text('Email address'),
            features: [
              input.InputHintFeature(
                popupBuilder: (context) =>
                    const Text('We never share your email.'),
              ),
              const input.InputClearFeature(),
              const input.InputCopyFeature(),
            ],
          ),
        ),
      ),
    );
  }
}
