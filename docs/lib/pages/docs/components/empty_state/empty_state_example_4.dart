import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/empty_state/empty_state.dart';
import '../../component_example_models.dart';

const ComponentExample emptyStateExample4 = ComponentExample(
  title: 'Two actions',
  builder: _buildEmptyStateExample4,
  code: '''EmptyState(
  variant: EmptyStateVariant.noResults,
  title: Text('No Results Found'),
  description: Text('Try adjusting your filters or search query.'),
  primaryAction: EmptyStateAction(label: 'Clear filters'),
  secondaryAction: EmptyStateAction(
    label: 'Try again',
    style: EmptyStateActionStyle.secondary,
  ),
)''',
);

Widget _buildEmptyStateExample4(BuildContext context) {
  return const EmptyState(
    variant: EmptyStateVariant.noResults,
    title: Text('No Results Found'),
    description: Text('Try adjusting your filters or search query.'),
    primaryAction: EmptyStateAction(label: 'Clear filters'),
    secondaryAction: EmptyStateAction(
      label: 'Try again',
      style: EmptyStateActionStyle.secondary,
    ),
  );
}
