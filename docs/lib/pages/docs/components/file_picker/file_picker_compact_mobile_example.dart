import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_picker/file_picker.dart'
    as shadcn_file_picker;
import '../../../../ui/shadcn/shared/icons/radix_icons.dart';
import 'file_picker_package_adapter.dart';

const ComponentExample filePickerCompactMobileExample = ComponentExample(
  title: 'Mobile icon + popover',
  builder: _buildFilePickerCompactMobileExample,
  code: '''FileUpload(
  pickFiles: pickFilesWithPackage, // package:file_picker
  title: Text('Attachments'),
  subtitle: Text('UI-only: connect pickFiles to any package.'),
  options: FileUploadMobileOptions(
    popover: true,
    trigger: FileUploadCompactTrigger.icon,
    popoverItems: [
      FileUploadPickOption(
        id: 'pick_images',
        label: 'Pick images',
        icon: Icon(RadixIcons.image),
        allowedMimeTypes: ['image/*'],
      ),
      FileUploadPickOption(
        id: 'pick_documents',
        label: 'Pick documents',
        icon: Icon(RadixIcons.fileText),
        allowedExtensions: ['pdf', 'doc', 'docx'],
      ),
    ],
  ),
  onFilesSelected: (files) {},
)''',
);

Widget _buildFilePickerCompactMobileExample(BuildContext context) {
  return shadcn_file_picker.FileUpload(
    pickFiles: pickFilesWithPackage,
    title: const Text('Attachments'),
    subtitle: const Text('UI-only: connect pickFiles to any package.'),
    options: const shadcn_file_picker.FileUploadMobileOptions(
      popover: true,
      trigger: shadcn_file_picker.FileUploadCompactTrigger.icon,
      popoverItems: [
        shadcn_file_picker.FileUploadPickOption(
          id: 'pick_images',
          label: 'Pick images',
          icon: Icon(RadixIcons.image),
          allowedMimeTypes: ['image/*'],
        ),
        shadcn_file_picker.FileUploadPickOption(
          id: 'pick_documents',
          label: 'Pick documents',
          icon: Icon(RadixIcons.fileText),
          allowedExtensions: ['pdf', 'doc', 'docx'],
        ),
      ],
    ),
    itemsMaxHeight: 220,
    onFilesSelected: (_) {},
  );
}
