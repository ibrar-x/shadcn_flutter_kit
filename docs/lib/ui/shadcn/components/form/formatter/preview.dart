import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../formatter/formatter.dart';

class FormatterPreview extends StatelessWidget {
  const FormatterPreview({super.key});

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
