# Time Picker

Pick times or durations using dialog or popover inputs.

## Usage
```dart
TimePicker(
  value: TimeOfDay(hour: 9, minute: 30),
  mode: PromptMode.popover,
  onChanged: (value) {},
)

DurationPicker(
  value: const Duration(hours: 1, minutes: 30),
  onChanged: (value) {},
)
```
