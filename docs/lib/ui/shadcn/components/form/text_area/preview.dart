import 'package:flutter/material.dart';
import '../text_area/text_area.dart';

class TextAreaPreview extends StatelessWidget {
  const TextAreaPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                // Basic text area with expandable height
                TextArea(
                  initialValue: 'Hello, World!',
                  expandableHeight: true,
                  initialHeight: 150,
                ),
                // With placeholder
                TextArea(
                  placeholder: Text('Type your message here...'),
                  expandableHeight: true,
                  initialHeight: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
