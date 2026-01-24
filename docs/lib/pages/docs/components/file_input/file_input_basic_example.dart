import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_input/file_input.dart'
    as shadcn_file_input;

const ComponentExample fileInputBasicExample = ComponentExample(
  title: 'Default icons',
  builder: _buildFileInputBasicExample,
  code: '''FileIconProvider.builder(
  child: Column(
    children: [
      _FileRow('design.pdf'),
      _FileRow('report.xlsx'),
    ],
  ),
)''',
);

Widget _buildFileInputBasicExample(BuildContext context) {
  return const shadcn_file_input.FileIconProvider.builder(
    child: _FileList(),
  );
}

class _FileList extends StatelessWidget {
  const _FileList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FileRow('design.pdf'),
        _FileRow('report.xlsx'),
        _FileRow('presentation.pptx'),
      ],
    );
  }
}

class _FileRow extends StatelessWidget {
  final String name;

  const _FileRow(this.name);

  @override
  Widget build(BuildContext context) {
    final extension = name.split('.').last;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          shadcn_file_input.FileIconProvider.buildIcon(context, extension),
          const SizedBox(width: 8),
          Text(name),
        ],
      ),
    );
  }
}
