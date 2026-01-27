part of '../../time_picker.dart';

/// Dialog widget for interactive duration selection.
///
/// Displays input fields for days, hours, minutes, and seconds
/// for selecting durations.
class DurationPickerDialog extends StatefulWidget {
  /// The initial duration value.
  final Duration? initialValue;

  /// Callback invoked when the duration changes.
  final ValueChanged<Duration?>? onChanged;

  /// Creates a duration picker dialog.
  const DurationPickerDialog({
    super.key,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<DurationPickerDialog> createState() => _DurationPickerDialogState();
}
