import 'package:flutter/material.dart' hide Slider;

import '../../../shared/primitives/slider_value.dart';
import '../slider/slider.dart';

part '_slider_preview_state.dart';


class SliderPreview extends StatefulWidget {
  const SliderPreview({super.key});

  @override
  State<SliderPreview> createState() => _SliderPreviewState();
}
