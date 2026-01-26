import 'package:flutter/material.dart';
import '../hsl/hsl_color_slider.dart';

class HslPreview extends StatefulWidget {
  const HslPreview({super.key});

  @override
  State<HslPreview> createState() => _HslPreviewState();
}

class _HslPreviewState extends State<HslPreview> {
  HSLColor _color = HSLColor.fromColor(Colors.blue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HSLColorSlider(
              color: _color,
              sliderType: HSLColorSliderType.hue,
              onChanged: (color) {
                setState(() {
                  _color = color;
                });
              },
            ),
            const SizedBox(height: 12),
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: _color.toColor(),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
