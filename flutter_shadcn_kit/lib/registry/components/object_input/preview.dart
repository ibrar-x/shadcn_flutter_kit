import 'package:flutter/material.dart';

import '../object_input/object_input.dart';

class ObjectInputPreview extends StatefulWidget {
  const ObjectInputPreview({super.key});

  @override
  State<ObjectInputPreview> createState() => _ObjectInputPreviewState();
}

class _ObjectInputPreviewState extends State<ObjectInputPreview> {
  DateTime? _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DateInput(
          initialValue: _value,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          placeholder: const Text('Pick date'),
        ),
      ),
    );
  }
}
