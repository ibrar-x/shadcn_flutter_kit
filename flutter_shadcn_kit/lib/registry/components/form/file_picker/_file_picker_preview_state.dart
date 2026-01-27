part of 'preview.dart';

class _FilePickerPreviewState extends State<FilePickerPreview> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          'FilePicker component - placeholder for file selection demo',
          style: TextStyle(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
