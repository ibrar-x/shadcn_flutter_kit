import 'package:flutter/material.dart';
import '../../display/calendar/calendar.dart';
import '../form_field/form_field.dart';
import '../date_picker/date_picker.dart';

part '_impl/state/_date_picker_preview_state.dart';

class DatePickerPreview extends StatefulWidget {
  const DatePickerPreview({super.key});

  @override
  State<DatePickerPreview> createState() => _DatePickerPreviewState();
}
