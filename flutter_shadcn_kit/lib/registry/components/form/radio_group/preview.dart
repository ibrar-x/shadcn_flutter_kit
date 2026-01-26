import 'package:flutter/material.dart' hide RadioGroup;

import '../radio_group/radio_group.dart';

class RadioGroupPreview extends StatefulWidget {
  const RadioGroupPreview({super.key});

  @override
  State<RadioGroupPreview> createState() => _RadioGroupPreviewState();
}

class _RadioGroupPreviewState extends State<RadioGroupPreview> {
  String? _value = 'starter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RadioGroup<String>(
          value: _value,
          onChanged: (value) => setState(() => _value = value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              RadioItem(
                value: 'starter',
                leading: Text('Starter'),
              ),
              SizedBox(height: 8),
              RadioItem(
                value: 'pro',
                leading: Text('Pro'),
              ),
              SizedBox(height: 8),
              RadioItem(
                value: 'enterprise',
                leading: Text('Enterprise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
