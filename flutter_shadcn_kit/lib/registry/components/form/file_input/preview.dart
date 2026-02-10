import 'package:flutter/material.dart';

class FileInputPreview extends StatelessWidget {
  const FileInputPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          'FileInput component is work-in-progress.',
          style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6)),
        ),
      ),
    );
  }
}
