# File Picker / Dropzone

Dropzone and list UI for selecting and managing uploaded files. Pairs well with
`file_picker` for cross‑platform file selection.

## Usage

```dart
import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/form/file_picker/file_picker.dart';

class FilePickerExample extends StatefulWidget {
  const FilePickerExample({super.key});

  @override
  State<FilePickerExample> createState() => _FilePickerExampleState();
}

class _FilePickerExampleState extends State<FilePickerExample> {
  final List<fp.PlatformFile> _files = [];

  Future<void> _pickFiles() async {
    final result = await fp.FilePicker.pickFiles(
      allowMultiple: true,
      withData: true,
      type: fp.FileType.any,
    );
    if (result == null) return;
    setState(() => _files
      ..clear()
      ..addAll(result.files));
  }

  @override
  Widget build(BuildContext context) {
    return FilePicker(
      title: const Text('Upload files'),
      subtitle: const Text('PDF, images, or any supported file type.'),
      hotDropEnabled: true,
      onAdd: _pickFiles,
      children: _files
          .map((file) => FileItem.platform(
                file: file,
                onRemove: () => setState(() => _files.remove(file)),
              ))
          .toList(),
    );
  }
}
```
