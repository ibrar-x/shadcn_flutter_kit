import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/empty_state/empty_state.dart';

const ComponentExample emptyStateExample3 = ComponentExample(
  title: 'Error fallback',
  builder: _buildEmptyStateExample3,
  code: '''EmptyState(
  variant: EmptyStateVariant.errorFallback,
  title: Text('Something went wrong'),
  description: Text('Please try again in a moment.'),
  primaryAction: EmptyStateAction(label: 'Retry'),
)''',
);

Widget _buildEmptyStateExample3(BuildContext context) {
  return const EmptyState(
    variant: EmptyStateVariant.errorFallback,
    title: Text('Something went wrong'),
    description: Text('Please try again in a moment.'),
    primaryAction: EmptyStateAction(label: 'Retry'),
  );
}
