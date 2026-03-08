import 'package:flutter/material.dart' hide Divider;
import '../divider/divider.dart';

/// Core class used by the divider component.
class DividerPreview extends StatelessWidget {
  const DividerPreview({super.key});

  /// Builds the widget tree for divider.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Item 1'),

              Divider(),

              Text('Item 2'),

              Divider(),

              Text('Item 3'),
            ],
          ),
        ),
      ),
    );
  }
}
