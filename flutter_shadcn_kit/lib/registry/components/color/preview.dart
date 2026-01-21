import 'package:flutter/material.dart';
import '../color/color.dart';
import '../color/color.dart';

class ColorPreview extends StatelessWidget {
  const ColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final derivative = ColorDerivative.fromColor(Colors.blue);
    final adjusted =
        derivative.changeToHSV(const HSVColor.fromAHSV(1, 210, 0.6, 0.8));
    final hex = colorToHex(adjusted.toColor(), true);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                color: adjusted.toColor(),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
            ),
            const SizedBox(height: 12),
            Text(hex),
          ],
        ),
      ),
    );
  }
}
