part of '../../preview.dart';

class _ObjectInputPreviewState extends State<ObjectInputPreview> {
  DateTime? _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DateInput(
          initialValue: _value,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          placeholder: const Text('Pick date'),
        ),
      ),
    );
  }
}
