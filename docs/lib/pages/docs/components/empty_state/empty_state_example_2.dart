import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/empty_state/empty_state.dart';

const ComponentExample emptyStateExample2 = ComponentExample(
  title: 'No results',
  builder: _buildEmptyStateExample2,
  code: '''EmptyState(
  variant: EmptyStateVariant.noResults,
  title: Text('No results'),
  description: Text('Try adjusting your filters or search.'),
  primaryAction: EmptyStateAction(label: 'Clear filters'),
)''',
);

Widget _buildEmptyStateExample2(BuildContext context) {
  return const EmptyState(
    variant: EmptyStateVariant.noResults,
    title: Text('No results'),
    description: Text('Try adjusting your filters or search.'),
    primaryAction: EmptyStateAction(label: 'Clear filters'),
  );
}
