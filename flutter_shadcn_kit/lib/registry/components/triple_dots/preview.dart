import 'package:flutter/material.dart';
import '../triple_dots/triple_dots.dart';
import '../triple_dots/triple_dots.dart';

class TripleDotsPreview extends StatelessWidget {
  const TripleDotsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            MoreDots(count: 3, spacing: 4),
            SizedBox(height: 12),
            MoreDots(direction: Axis.vertical, count: 5, spacing: 6),
          ],
        ),
      ),
    );
  }
}
