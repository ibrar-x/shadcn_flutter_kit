import 'package:flutter/material.dart' hide TimeOfDay;

import '../../shared/utils/util.dart';
import '../form_field/form_field.dart';
import '../time_picker/time_picker.dart';

class TimePickerPreview extends StatefulWidget {
  const TimePickerPreview({super.key});

  @override
  State<TimePickerPreview> createState() => _TimePickerPreviewState();
}

class _TimePickerPreviewState extends State<TimePickerPreview> {
  TimeOfDay? _time;
  Duration? _duration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TimePicker(
              value: _time,
              mode: PromptMode.popover,
              showSeconds: true,
              onChanged: (value) {
                setState(() {
                  _time = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DurationPicker(
              value: _duration,
              mode: PromptMode.dialog,
              onChanged: (value) {
                setState(() {
                  _duration = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
