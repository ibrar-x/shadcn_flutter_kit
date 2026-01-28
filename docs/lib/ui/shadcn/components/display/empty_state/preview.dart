import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../layout/scaffold/scaffold.dart';
import '../../../shared/theme/theme.dart';
import 'empty_state.dart';

class EmptyStatePreview extends StatelessWidget {
  const EmptyStatePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: const [AppBar(title: Text('Empty State'))],
      child: Builder(
        builder: (context) {
          final scaling = Theme.of(context).scaling;
          return ListView(
            padding: EdgeInsets.all(24 * scaling),
            children: [
              const EmptyState(
                variant: EmptyStateVariant.empty,
                size: EmptyStateSize.compact,
                primaryAction: EmptyStateAction(
                  label: 'Create item',
                ),
                secondaryAction: EmptyStateAction(
                  label: 'Import',
                  style: EmptyStateActionStyle.link,
                ),
              ),
              Gap(24 * scaling),
              const EmptyState(
                variant: EmptyStateVariant.noResults,
                primaryAction: EmptyStateAction(label: 'Clear filters'),
                secondaryAction: EmptyStateAction(
                  label: 'Try search',
                  style: EmptyStateActionStyle.secondary,
                  onPressed: null,
                ),
              ),
              Gap(24 * scaling),
              const EmptyState(
                variant: EmptyStateVariant.errorFallback,
                primaryAction: EmptyStateAction(label: 'Retry'),
              ),
            ],
          );
        },
      ),
    );
  }
}
