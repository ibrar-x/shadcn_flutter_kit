import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_picker/file_picker.dart'
    as shadcn_file_picker;

const ComponentExample filePickerBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildFilePickerBasicExample,
  code: '''FileUpload(
  title: Text('Upload files'),
  subtitle: Text('PNG, JPG, or PDF up to 5MB'),
  allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
  maxFileSizeBytes: 5 * 1024 * 1024,
  onFilesSelected: (files) {},
)''',
);

Widget _buildFilePickerBasicExample(BuildContext context) {
  return shadcn_file_picker.FileUpload(
    title: const Text('Upload files'),
    subtitle: const Text('PNG, JPG, or PDF up to 5MB'),
    allowedExtensions: const ['png', 'jpg', 'jpeg', 'pdf'],
    maxFileSizeBytes: 5 * 1024 * 1024,
    actionLabel: 'Browse files',
    itemsMaxHeight: 220,
    onFilesSelected: (_) {},
  );
}
