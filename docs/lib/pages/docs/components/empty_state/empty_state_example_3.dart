import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/empty_state/empty_state.dart';
import '../../../../ui/shadcn/shared/icons/radix_icons.dart';

const ComponentExample emptyStateExample3 = ComponentExample(
  title: 'Single action',
  builder: _buildEmptyStateExample3,
  code: '''EmptyState(
  icon: Icon(RadixIcons.upload),
  title: Text('No Files Uploaded'),
  description: Text('Upload your first file or import from cloud storage.'),
  primaryAction: EmptyStateAction(label: 'Upload Files'),
)''',
);

Widget _buildEmptyStateExample3(BuildContext context) {
  return const EmptyState(
    icon: Icon(RadixIcons.upload),
    title: Text('No Files Uploaded'),
    description: Text('Upload your first file or import from cloud storage.'),
    primaryAction: EmptyStateAction(label: 'Upload Files'),
  );
}
