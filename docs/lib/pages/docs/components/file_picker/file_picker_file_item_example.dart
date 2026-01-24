import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';

const ComponentExample filePickerFileItemExample = ComponentExample(
  title: 'File item (WIP)',
  builder: _buildFilePickerFileItemExample,
  code: '''FileItem(
  fileName: Text('report.pdf'),
  fileSize: Text('1.2 MB'),
  uploadProgress: 0.6,
)''',
);

Widget _buildFilePickerFileItemExample(BuildContext context) {
  return const _WipNotice();
}

class _WipNotice extends StatelessWidget {
  const _WipNotice();

  @override
  Widget build(BuildContext context) {
    return const Text('FilePicker is not yet implemented in the registry.');
  }
}
