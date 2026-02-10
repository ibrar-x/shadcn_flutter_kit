import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_picker/file_picker.dart'
    as shadcn_file_picker;
import '../../../../ui/shadcn/shared/icons/radix_icons.dart';
import 'file_picker_package_adapter.dart';

const ComponentExample filePickerMobileIconExample = ComponentExample(
  title: 'Mobile icon',
  builder: _buildFilePickerMobileIconExample,
  code: '''FileUpload(
  pickFiles: pickFilesWithPackage, // package:file_picker
  title: Text('Quick attach'),
  subtitle: Text('UI-only: connect pickFiles to file_picker/image_picker/etc.'),
  options: FileUploadMobileOptions(
    trigger: FileUploadCompactTrigger.icon,
    icon: Icon(RadixIcons.upload),
  ),
)''',
);

Widget _buildFilePickerMobileIconExample(BuildContext context) {
  return shadcn_file_picker.FileUpload(
    pickFiles: pickFilesWithPackage,
    title: const Text('Quick attach'),
    subtitle: const Text(
      'UI-only: connect pickFiles to file_picker/image_picker/etc.',
    ),
    options: const shadcn_file_picker.FileUploadMobileOptions(
      trigger: shadcn_file_picker.FileUploadCompactTrigger.icon,
      icon: Icon(RadixIcons.upload),
    ),
    itemsMaxHeight: 220,
    onFilesSelected: (_) {},
  );
}
