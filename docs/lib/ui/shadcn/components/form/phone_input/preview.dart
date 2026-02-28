import 'package:flutter/material.dart';

import '../phone_input/phone_input.dart';

/// PhoneInputPreview renders form UI and wires input behavior.
class PhoneInputPreview extends StatelessWidget {
  const PhoneInputPreview({super.key});

  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(width: 320, child: PhoneInput(onChanged: (_) {})),
      ),
    );
  }
}
