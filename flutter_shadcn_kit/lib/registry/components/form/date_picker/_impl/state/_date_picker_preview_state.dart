part of '../../preview.dart';

class _DatePickerPreviewState extends State<DatePickerPreview> {
  DateTime? _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            // Popover mode date picker
            DatePicker(
              value: _value,
              mode: PromptMode.popover,
              stateBuilder: (date) {
                if (date.isAfter(DateTime.now())) {
                  return DateState.disabled;
                }
                return DateState.enabled;
              },
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            // Dialog mode date picker
            DatePicker(
              value: _value,
              mode: PromptMode.dialog,
              dialogTitle: const Text('Pick a date'),
              stateBuilder: (date) {
                if (date.isAfter(DateTime.now())) {
                  return DateState.disabled;
                }
                return DateState.enabled;
              },
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
