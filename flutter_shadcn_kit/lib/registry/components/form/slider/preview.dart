import 'dart:math';

import 'package:flutter/material.dart' hide Slider, SliderTheme, Theme;

import '../../../shared/theme/theme.dart';
import '../slider/_impl/core/shad_slider_models.dart';
import '../slider/_impl/styles/shad_slider_defaults.dart';
import '../slider/shad_slider.dart';

part '_impl/state/_slider_preview_state.dart';

/// SliderPreview represents a form-related type in the registry.
class SliderPreview extends StatefulWidget {
  const SliderPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<SliderPreview> createState() => _SliderPreviewState();
}
