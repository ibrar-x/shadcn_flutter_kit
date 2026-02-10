import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_picker/file_picker.dart'
    as shadcn_file_picker;
import 'file_picker_package_adapter.dart';

const ComponentExample filePickerTileExample = ComponentExample(
  title: 'Tile',
  builder: _buildFilePickerTileExample,
  code: '''FileUpload(
  pickFiles: pickFilesWithPackage, // package:file_picker
  title: Text('Upload statement'),
  subtitle: Text('UI-only: wire pickFiles to any package you prefer.'),
  allowedExtensions: ['pdf', 'csv'],
  maxFileSizeBytes: 10 * 1024 * 1024,
  options: FileUploadTileOptions(
    actionLabel: 'Choose file',
    subtitle: Text('No file chosen'),
    hint: Text('Accepted: PDF or CSV (max 10MB).'),
  ),
)''',
);

Widget _buildFilePickerTileExample(BuildContext context) {
  return shadcn_file_picker.FileUpload(
    pickFiles: pickFilesWithPackage,
    title: const Text('Upload statement'),
    subtitle: const Text('UI-only: wire pickFiles to any package you prefer.'),
    allowedExtensions: const ['pdf', 'csv'],
    maxFileSizeBytes: 10 * 1024 * 1024,
    options: const shadcn_file_picker.FileUploadTileOptions(
      actionLabel: 'Choose file',
      subtitle: Text('No file chosen'),
      hint: Text('Accepted: PDF or CSV (max 10MB).'),
    ),
    itemsMaxHeight: 220,
    onFilesSelected: (_) {},
  );
}
