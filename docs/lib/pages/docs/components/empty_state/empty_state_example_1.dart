import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/empty_state/empty_state.dart';
import '../../../../ui/shadcn/shared/icons/radix_icons.dart';
import '../../component_example_models.dart';

const ComponentExample emptyStateExample1 = ComponentExample(
  title: 'Simple (No actions)',
  builder: _buildEmptyStateExample1,
  code: '''EmptyState(
  icon: Icon(RadixIcons.archive),
  title: Text('Nothing Here Yet'),
  description: Text('Create your first item to get started.'),
)''',
);

Widget _buildEmptyStateExample1(BuildContext context) {
  return const EmptyState(
    icon: Icon(RadixIcons.archive),
    title: Text('Nothing Here Yet'),
    description: Text('Create your first item to get started.'),
  );
}
