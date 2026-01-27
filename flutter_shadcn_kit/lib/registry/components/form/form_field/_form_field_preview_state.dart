part of 'preview.dart';

class _FormFieldPreviewState extends State<FormFieldPreview> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ObjectFormField<String>(
          value: _value,
          placeholder: const Text('Select option'),
          builder: (context, value) => Text(value),
          editorBuilder: (context, handler) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Option 1'),
                onTap: () {
                  handler.value = 'Option 1';
                  handler.close();
                },
              ),
              ListTile(
                title: const Text('Option 2'),
                onTap: () {
                  handler.value = 'Option 2';
                  handler.close();
                },
              ),
              ListTile(
                title: const Text('Option 3'),
                onTap: () {
                  handler.value = 'Option 3';
                  handler.close();
                },
              ),
            ],
          ),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          mode: PromptMode.dialog,
        ),
      ),
    );
  }
}
