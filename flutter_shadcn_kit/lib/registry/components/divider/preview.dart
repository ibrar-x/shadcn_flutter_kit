import 'package:flutter/material.dart' hide Divider;
import '../divider/divider.dart';
import '../divider/divider.dart';

class DividerPreview extends StatelessWidget {
  const DividerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Item 1'),
              const Divider(),
              const Text('Item 2'),
              const Divider(),
              const Text('Item 3'),
            ],
          ),
        ),
      ),
    );
  }
}
