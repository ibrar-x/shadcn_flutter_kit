import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/empty_state/empty_state.dart';
import '../../../../ui/shadcn/shared/icons/radix_icons.dart';

const ComponentExample emptyStateExample2 = ComponentExample(
  title: 'Compact card',
  builder: _buildEmptyStateExample2,
  code: '''EmptyState(
  size: EmptyStateSize.compact,
  icon: Icon(RadixIcons.magnifyingGlass),
  title: Text('No Results'),
  description: Text('Try adjusting filters or search terms.'),
  showIconContainer: false,
)''',
);

Widget _buildEmptyStateExample2(BuildContext context) {
  return const EmptyState(
    size: EmptyStateSize.compact,
    icon: Icon(RadixIcons.magnifyingGlass),
    title: Text('No Results'),
    description: Text('Try adjusting filters or search terms.'),
    showIconContainer: false,
  );
}
