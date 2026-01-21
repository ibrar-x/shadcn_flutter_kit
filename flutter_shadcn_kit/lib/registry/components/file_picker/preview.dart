import 'package:flutter/material.dart';

class FilePickerPreview extends StatefulWidget {
  const FilePickerPreview({super.key});

  @override
  State<FilePickerPreview> createState() => _FilePickerPreviewState();
}

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
