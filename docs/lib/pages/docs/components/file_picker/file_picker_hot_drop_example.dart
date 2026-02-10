import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_picker/file_picker.dart'
    as shadcn_file_picker;
import '../../../../ui/shadcn/shared/icons/radix_icons.dart';
import 'file_picker_package_adapter.dart';

const ComponentExample filePickerHotDropExample = ComponentExample(
  title: 'Drag & drop',
  builder: _buildFilePickerHotDropExample,
  code: '''FileUpload(
  pickFiles: pickFilesWithPackage, // package:file_picker
  title: Text('Drop files here'),
  subtitle: Text('Drag files onto the dropzone'),
  options: FileUploadDragDropOptions(
    enableDragDrop: true,
    icon: Icon(RadixIcons.upload),
    hint: Text('Drop files or click to browse'),
  ),
)''',
);

Widget _buildFilePickerHotDropExample(BuildContext context) {
  return shadcn_file_picker.FileUpload(
    pickFiles: pickFilesWithPackage,
    title: const Text('Drop files here'),
    subtitle: const Text('Drag files onto the dropzone'),
    options: const shadcn_file_picker.FileUploadDragDropOptions(
      enableDragDrop: true,
      icon: Icon(RadixIcons.upload),
      hint: Text('Drop files or click to browse'),
    ),
    itemsMaxHeight: 220,
    onFilesSelected: (_) {},
  );
}
