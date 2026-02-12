import 'package:flutter/material.dart';

import '../hsv/hsv_color_slider.dart';

part '_impl/state/_hsv_preview_state.dart';

/// HsvPreview represents a form-related type in the registry.
class HsvPreview extends StatefulWidget {
  const HsvPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<HsvPreview> createState() => _HsvPreviewState();
}
