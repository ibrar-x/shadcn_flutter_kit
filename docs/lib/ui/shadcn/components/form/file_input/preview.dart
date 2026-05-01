import 'package:flutter/material.dart';

/// FileInputPreview renders form UI and wires input behavior.
class FileInputPreview extends StatelessWidget {
  const FileInputPreview({super.key});

  /// Builds the widget tree for this component state.
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
