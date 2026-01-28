import 'package:flutter/widgets.dart';

import 'registry/composites/layout/app/app.dart';
import 'registry/components/form/file_picker/preview.dart';
import 'registry/shared/theme/theme.dart';

void main() {
  runApp(const FilePickerDemoApp());
}

class FilePickerDemoApp extends StatelessWidget {
  const FilePickerDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'File Picker',
      debugShowCheckedModeBanner: false,
      theme: const ThemeData(),
      home: const FilePickerPreview(),
    );
  }
}
