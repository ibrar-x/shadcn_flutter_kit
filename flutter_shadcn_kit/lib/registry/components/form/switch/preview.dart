import 'package:flutter/material.dart' hide Switch;

import '../switch/switch.dart';

class SwitchPreview extends StatefulWidget {
  const SwitchPreview({super.key});

  @override
  State<SwitchPreview> createState() => _SwitchPreviewState();
}

class _SwitchPreviewState extends State<SwitchPreview> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            // Interactive switch
            Switch(
              value: value,
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            ),
            // Disabled switches
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Switch(
                  value: false,
                  onChanged: null,
                ),
                Switch(
                  value: true,
                  onChanged: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
