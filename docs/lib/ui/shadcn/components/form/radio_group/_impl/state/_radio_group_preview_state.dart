part of '../../preview.dart';

class _RadioGroupPreviewState extends State<RadioGroupPreview> {
  String? _value = 'starter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RadioGroup<String>(
          value: _value,
          onChanged: (value) => setState(() => _value = value),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioItem(
                value: 'starter',
                leading: Text('Starter'),
              ),
              SizedBox(height: 8),
              RadioItem(
                value: 'pro',
                leading: Text('Pro'),
              ),
              SizedBox(height: 8),
              RadioItem(
                value: 'enterprise',
                leading: Text('Enterprise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
