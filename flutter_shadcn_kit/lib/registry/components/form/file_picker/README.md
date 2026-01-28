# File Upload / Dropzone

Dropzone and list UI for selecting and managing uploaded files. Pairs well with
`file_picker` for cross‑platform file selection.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/form/file_picker/file_picker.dart';

class FileUploadExample extends StatelessWidget {
  const FileUploadExample({super.key});

  Stream<double> _upload(FileLike file) async* {
    const steps = 12;
    for (var i = 1; i <= steps; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 120));
      yield i / steps;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FileUpload(
      title: const Text('Upload files'),
      subtitle: const Text('PDF, images, or any supported file type.'),
      allowMultiple: true,
      maxFiles: 5,
      maxFileSizeBytes: 10 * 1024 * 1024,
      allowedExtensions: const ['pdf', 'png', 'jpg', 'jpeg'],
      uploadFn: _upload,
      onFilesSelected: (files) {
        // optional hook for analytics / custom uploads
      },
    );
  }
}
```
