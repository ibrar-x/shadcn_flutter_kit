import 'package:flutter/material.dart';
import '../hsl/hsl_color_slider.dart';

part '_impl/state/_hsl_preview_state.dart';

/// HslPreview represents a form-related type in the registry.
class HslPreview extends StatefulWidget {
  const HslPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<HslPreview> createState() => _HslPreviewState();
}
