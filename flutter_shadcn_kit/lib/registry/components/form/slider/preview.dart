import 'package:flutter/material.dart' hide Slider, SliderTheme, Theme;

import '../../../shared/primitives/slider_value.dart';
import '../../../shared/theme/theme.dart';
import '../slider/slider.dart';

part '_impl/state/_slider_preview_state.dart';

/// SliderPreview represents a form-related type in the registry.
class SliderPreview extends StatefulWidget {
  const SliderPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<SliderPreview> createState() => _SliderPreviewState();
}
