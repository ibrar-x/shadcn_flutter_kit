import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_picker/file_picker.dart'
    as shadcn_file_picker;
import 'file_picker_package_adapter.dart';

const ComponentExample filePickerBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildFilePickerBasicExample,
  code: '''FileUpload(
  pickFiles: pickFilesWithPackage, // package:file_picker
  title: Text('Upload files'),
  subtitle: Text('PNG, JPG, or PDF up to 5MB (works with any picker package).'),
  allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
  maxFileSizeBytes: 5 * 1024 * 1024,
  options: FileUploadDragDropOptions(),
  onFilesSelected: (files) {},
)''',
);

Widget _buildFilePickerBasicExample(BuildContext context) {
  return shadcn_file_picker.FileUpload(
    pickFiles: pickFilesWithPackage,
    title: const Text('Upload files'),
    subtitle: const Text(
      'PNG, JPG, or PDF up to 5MB (works with any picker package).',
    ),
    allowedExtensions: const ['png', 'jpg', 'jpeg', 'pdf'],
    maxFileSizeBytes: 5 * 1024 * 1024,
    options: const shadcn_file_picker.FileUploadDragDropOptions(),
    itemsMaxHeight: 220,
    onFilesSelected: (_) {},
  );
}
