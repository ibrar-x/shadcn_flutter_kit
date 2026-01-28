import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_picker/file_picker.dart'
    as shadcn_file_picker;
import '../../../../ui/shadcn/shared/icons/radix_icons.dart';

const ComponentExample filePickerHotDropExample = ComponentExample(
  title: 'Drag & drop',
  builder: _buildFilePickerHotDropExample,
  code: '''FileUpload(
  title: Text('Drop files here'),
  subtitle: Text('Drag files onto the dropzone'),
  enableDragDrop: true,
  hint: Text('Drop files or click to browse'),
  icon: Icon(RadixIcons.upload),
)''',
);

Widget _buildFilePickerHotDropExample(BuildContext context) {
  return shadcn_file_picker.FileUpload(
    title: const Text('Drop files here'),
    subtitle: const Text('Drag files onto the dropzone'),
    enableDragDrop: true,
    hint: const Text('Drop files or click to browse'),
    icon: const Icon(RadixIcons.upload),
    actionLabel: 'Browse',
    itemsMaxHeight: 220,
    onFilesSelected: (_) {},
  );
}
