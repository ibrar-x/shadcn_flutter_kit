import 'package:flutter/material.dart' hide TimeOfDay;

import '../../../shared/utils/util.dart';
import '../form_field/form_field.dart';
import '../time_picker/time_picker.dart';

part '_impl/state/_time_picker_preview_state.dart';

/// TimePickerPreview represents a form-related type in the registry.
class TimePickerPreview extends StatefulWidget {
  const TimePickerPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<TimePickerPreview> createState() => _TimePickerPreviewState();
}
