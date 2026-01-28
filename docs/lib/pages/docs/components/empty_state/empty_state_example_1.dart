import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/empty_state/empty_state.dart';

const ComponentExample emptyStateExample1 = ComponentExample(
  title: 'Empty state',
  builder: _buildEmptyStateExample1,
  code: '''EmptyState(
  title: Text('No projects yet'),
  description: Text('Create your first project to get started.'),
  primaryAction: EmptyStateAction(label: 'Create project'),
  secondaryAction: EmptyStateAction(
    label: 'Import',
    style: EmptyStateActionStyle.link,
  ),
)''',
);

Widget _buildEmptyStateExample1(BuildContext context) {
  return const EmptyState(
    title: Text('No projects yet'),
    description: Text('Create your first project to get started.'),
    primaryAction: EmptyStateAction(label: 'Create project'),
    secondaryAction: EmptyStateAction(
      label: 'Import',
      style: EmptyStateActionStyle.link,
    ),
  );
}
