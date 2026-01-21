import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../formatter/formatter.dart';
import '../formatter/formatter.dart';

class FormatterPreview extends StatelessWidget {
  const FormatterPreview({super.key});

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
