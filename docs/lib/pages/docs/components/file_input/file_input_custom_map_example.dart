import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_input/file_input.dart'
    as shadcn_file_input;

const ComponentExample fileInputCustomMapExample = ComponentExample(
  title: 'Custom icon map',
  builder: _buildFileInputCustomMapExample,
  code: '''FileIconProvider(
  icons: {
    'sketch': Icon(Icons.brush),
    'fig': Icon(Icons.palette),
  },
  child: _FileRow('wireframe.fig'),
)''',
);

Widget _buildFileInputCustomMapExample(BuildContext context) {
  return const shadcn_file_input.FileIconProvider(
    icons: {
      'sketch': Icon(Icons.brush),
      'fig': Icon(Icons.palette),
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FileRow('wireframe.fig'),
        _FileRow('logo.sketch'),
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
