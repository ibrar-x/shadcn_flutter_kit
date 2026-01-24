import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_input/file_input.dart'
    as shadcn_file_input;

const ComponentExample fileInputCustomBuilderExample = ComponentExample(
  title: 'Custom builder',
  builder: _buildFileInputCustomBuilderExample,
  code: '''FileIconProvider.builder(
  builder: (extension) => Icon(Icons.insert_drive_file),
  child: _FileRow('notes.txt'),
)''',
);

Widget _buildFileInputCustomBuilderExample(BuildContext context) {
  return shadcn_file_input.FileIconProvider.builder(
    builder: (extension) {
      switch (extension) {
        case 'md':
          return const Icon(Icons.description);
        case 'txt':
          return const Icon(Icons.notes);
        default:
          return const Icon(Icons.insert_drive_file);
      }
    },
    child: const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FileRow('notes.txt'),
        _FileRow('readme.md'),
      ],
    ),
  );
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
