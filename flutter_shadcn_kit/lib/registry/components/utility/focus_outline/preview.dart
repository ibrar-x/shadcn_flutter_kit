import 'package:flutter/material.dart';
import '../focus_outline/focus_outline.dart';

class FocusOutlinePreview extends StatelessWidget {
  const FocusOutlinePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FocusOutline(
              focused: true,
              child: TextButton(
                onPressed: () {},
                child: const Text('Focused'),
              ),
            ),
            const SizedBox(height: 12),
            FocusOutline(
              focused: false,
              child: TextButton(
                onPressed: () {},
                child: const Text('Unfocused'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
