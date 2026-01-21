import 'package:flutter/material.dart' hide Slider;

import '../../shared/primitives/slider_value.dart';
import '../slider/slider.dart';

class SliderPreview extends StatefulWidget {
  const SliderPreview({super.key});

  @override
  State<SliderPreview> createState() => _SliderPreviewState();
}

class _SliderPreviewState extends State<SliderPreview> {
  SliderValue _value = SliderValue.single(0.4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: Slider(
            value: _value,
            onChanged: (value) => setState(() => _value = value),
            min: 0,
            max: 1,
          ),
        ),
      ),
    );
  }
}
