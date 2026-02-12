import 'package:flutter/material.dart' hide RadioGroup;

import '../radio_group/radio_group.dart';

part '_impl/state/_radio_group_preview_state.dart';

/// RadioGroupPreview represents a form-related type in the registry.
class RadioGroupPreview extends StatefulWidget {
  const RadioGroupPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<RadioGroupPreview> createState() => _RadioGroupPreviewState();
}
