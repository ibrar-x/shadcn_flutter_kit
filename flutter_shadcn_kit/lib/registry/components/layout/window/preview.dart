import 'package:flutter/material.dart';

import '../window/window.dart';

class WindowPreview extends StatelessWidget {
  const WindowPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final window = Window(
      title: const Text('Notes'),
      bounds: const Rect.fromLTWH(60, 40, 320, 220),
      content: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Drag or resize this window.'),
      ),
    );
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 600,
          height: 400,
          child: WindowNavigator(
            initialWindows: [window],
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.grey.shade100),
            ),
          ),
        ),
      ),
    );
  }
}
