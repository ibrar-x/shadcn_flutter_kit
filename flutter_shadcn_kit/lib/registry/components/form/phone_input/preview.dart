import 'package:flutter/material.dart';

import '../phone_input/phone_input.dart';

class PhoneInputPreview extends StatelessWidget {
  const PhoneInputPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(width: 320, child: PhoneInput(onChanged: (_) {})),
      ),
    );
  }
}
