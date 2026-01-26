import 'package:flutter/material.dart' hide TextField;

import '../text_field/text_field.dart';

class TextFieldPreview extends StatelessWidget {
  const TextFieldPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TextField(
                placeholder: Text('Enter your name'),
              ),
              SizedBox(height: 16),
              TextField(
                placeholder: Text('Search...'),
                features: [
                  InputFeature.clear(),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                placeholder: Text('Password'),
                obscureText: true,
                features: [
                  InputFeature.passwordToggle(),
                  InputFeature.clear(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
