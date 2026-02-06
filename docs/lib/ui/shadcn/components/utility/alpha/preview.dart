import 'package:flutter/material.dart';
import '../alpha/alpha.dart';

class AlphaPreview extends StatelessWidget {
  const AlphaPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 220,
          height: 48,
          child: CustomPaint(
            painter: AlphaPainter(),
            child: Container(
              alignment: Alignment.center,
              child: const Text('Alpha grid'),
            ),
          ),
        ),
      ),
    );
  }
}
