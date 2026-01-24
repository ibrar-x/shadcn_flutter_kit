import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';

const ComponentExample filePickerHotDropExample = ComponentExample(
  title: 'Hot drop state (WIP)',
  builder: _buildFilePickerHotDropExample,
  code: '''FilePicker(
  hotDropEnabled: true,
  hotDropping: true,
  children: [],
)''',
);

Widget _buildFilePickerHotDropExample(BuildContext context) {
  return const _WipNotice();
}

class _WipNotice extends StatelessWidget {
  const _WipNotice();

  @override
  Widget build(BuildContext context) {
    return const Text('FilePicker is not yet implemented in the registry.');
  }
}
