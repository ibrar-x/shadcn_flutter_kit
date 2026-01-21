import 'package:flutter/material.dart';

import '../switcher/switcher.dart';

class SwitcherPreview extends StatefulWidget {
  const SwitcherPreview({super.key});

  @override
  State<SwitcherPreview> createState() => _SwitcherPreviewState();
}

class _SwitcherPreviewState extends State<SwitcherPreview> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          height: 180,
          child: Switcher(
            index: _index,
            direction: AxisDirection.left,
            onIndexChanged: (value) => setState(() => _index = value),
            children: [
              Container(
                color: Colors.blue.shade100,
                alignment: Alignment.center,
                child: const Text('Page 1'),
              ),
              Container(
                color: Colors.green.shade100,
                alignment: Alignment.center,
                child: const Text('Page 2'),
              ),
              Container(
                color: Colors.orange.shade100,
                alignment: Alignment.center,
                child: const Text('Page 3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
