import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';

const ComponentExample filePickerBasicExample = ComponentExample(
  title: 'Basic layout (WIP)',
  builder: _buildFilePickerBasicExample,
  code: '''FilePicker(
  title: Text('Upload files'),
  subtitle: Text('Drag or click to upload'),
  onAdd: () {},
  children: [],
)''',
);

Widget _buildFilePickerBasicExample(BuildContext context) {
  return const _WipNotice();
}

class _WipNotice extends StatelessWidget {
  const _WipNotice();

  @override
  Widget build(BuildContext context) {
    return const Text('FilePicker is not yet implemented in the registry.');
  }
}
