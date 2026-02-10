import 'package:flutter/material.dart' hide TimeOfDay;

import '../../../shared/utils/util.dart';
import '../form_field/form_field.dart';
import '../time_picker/time_picker.dart';

part '_impl/state/_time_picker_preview_state.dart';

class TimePickerPreview extends StatefulWidget {
  const TimePickerPreview({super.key});

  @override
  State<TimePickerPreview> createState() => _TimePickerPreviewState();
}
