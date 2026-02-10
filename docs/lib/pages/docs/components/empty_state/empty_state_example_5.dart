import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/empty_state/empty_state.dart';
import '../../../../ui/shadcn/shared/icons/radix_icons.dart';
import '../../component_example_models.dart';

const ComponentExample emptyStateExample5 = ComponentExample(
  title: 'Complex / Product empty screen',
  builder: _buildEmptyStateExample5,
  code: '''EmptyState(
  icon: Icon(RadixIcons.filePlus),
  title: Text('No Projects Yet'),
  description: Text(
    "You haven't created any projects yet. Get started by creating your first project.",
  ),
  primaryAction: EmptyStateAction(label: 'Create Project'),
  secondaryAction: EmptyStateAction(
    label: 'Import Project',
    style: EmptyStateActionStyle.secondary,
  ),
  footerAction: EmptyStateAction(
    label: 'Learn More',
    style: EmptyStateActionStyle.link,
    trailingIcon: Icon(RadixIcons.arrowTopRight),
  ),
)''',
);

Widget _buildEmptyStateExample5(BuildContext context) {
  return const EmptyState(
    icon: Icon(RadixIcons.filePlus),
    title: Text('No Projects Yet'),
    description: Text(
      "You haven't created any projects yet. Get started by creating your first project.",
    ),
    primaryAction: EmptyStateAction(label: 'Create Project'),
    secondaryAction: EmptyStateAction(
      label: 'Import Project',
      style: EmptyStateActionStyle.secondary,
    ),
    footerAction: EmptyStateAction(
      label: 'Learn More',
      style: EmptyStateActionStyle.link,
      trailingIcon: Icon(RadixIcons.arrowTopRight),
    ),
  );
}
