import 'package:flutter/widgets.dart';

import '../../../../../shared/icons/radix_icons.dart';
import '../variants/empty_state_variant.dart';

IconData defaultEmptyStateIcon(EmptyStateVariant variant) {
  switch (variant) {
    case EmptyStateVariant.noResults:
      return RadixIcons.magnifyingGlass;
    case EmptyStateVariant.errorFallback:
      return RadixIcons.exclamationTriangle;
    case EmptyStateVariant.empty:
      return RadixIcons.archive;
  }
}

String defaultEmptyStateTitle(EmptyStateVariant variant) {
  switch (variant) {
    case EmptyStateVariant.noResults:
      return 'No results found';
    case EmptyStateVariant.errorFallback:
      return 'Something went wrong';
    case EmptyStateVariant.empty:
      return 'Nothing here yet';
  }
}

String defaultEmptyStateDescription(EmptyStateVariant variant) {
  switch (variant) {
    case EmptyStateVariant.noResults:
      return 'Try adjusting your filters or search terms.';
    case EmptyStateVariant.errorFallback:
      return 'We couldn’t load this data. Try again in a moment.';
    case EmptyStateVariant.empty:
      return 'Create your first item to get started.';
  }
}
