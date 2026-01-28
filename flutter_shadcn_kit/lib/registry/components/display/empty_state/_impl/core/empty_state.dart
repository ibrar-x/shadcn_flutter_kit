import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../../../../shared/theme/theme.dart';
import '../../../../control/button/button.dart';
import '../../../../display/divider/divider.dart';
import '../../../../layout/card/card.dart';
import '../utils/empty_state_defaults.dart';
import '../variants/empty_state_action_style.dart';
import '../variants/empty_state_size.dart';
import '../variants/empty_state_variant.dart';
import 'empty_state_action.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.variant = EmptyStateVariant.empty,
    this.size = EmptyStateSize.fullPage,
    this.icon,
    this.title,
    this.description,
    this.primaryAction,
    this.secondaryAction,
    this.maxWidth,
  });

  final EmptyStateVariant variant;
  final EmptyStateSize size;
  final Widget? icon;
  final Widget? title;
  final Widget? description;
  final EmptyStateAction? primaryAction;
  final EmptyStateAction? secondaryAction;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final resolvedTitle = title ?? Text(defaultEmptyStateTitle(variant));
    final resolvedDescription =
        description ?? Text(defaultEmptyStateDescription(variant));
    final resolvedIcon =
        icon ??
        Icon(
          defaultEmptyStateIcon(variant),
          size: size == EmptyStateSize.compact ? 28 * scaling : 36 * scaling,
          color: theme.colorScheme.mutedForeground,
        );

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        resolvedIcon,
        Gap(12 * scaling),
        DefaultTextStyle.merge(
          style: theme.typography.medium.merge(theme.typography.semiBold),
          textAlign: TextAlign.center,
          child: resolvedTitle,
        ),
        Gap(6 * scaling),
        DefaultTextStyle.merge(
          style: theme.typography.small.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
          textAlign: TextAlign.center,
          child: resolvedDescription,
        ),
        if (primaryAction != null || secondaryAction != null)
          Padding(
            padding: EdgeInsets.only(top: 16 * scaling),
            child: Divider(),
          ),
        if (primaryAction != null || secondaryAction != null)
          Padding(
            padding: EdgeInsets.only(top: 16 * scaling),
            child: Wrap(
              spacing: 12 * scaling,
              runSpacing: 8 * scaling,
              alignment: WrapAlignment.center,
              children: [
                if (primaryAction != null)
                  _buildAction(context, primaryAction!, isPrimary: true),
                if (secondaryAction != null)
                  _buildAction(context, secondaryAction!, isPrimary: false),
              ],
            ),
          ),
      ],
    );

    final constrained = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth ?? 520 * scaling),
      child: Padding(
        padding: EdgeInsets.all(size == EmptyStateSize.compact
            ? 20 * scaling
            : 32 * scaling),
        child: content,
      ),
    );

    if (size == EmptyStateSize.compact) {
      return Card(child: constrained);
    }

    return Center(child: constrained);
  }

  Widget _buildAction(
    BuildContext context,
    EmptyStateAction action, {
    required bool isPrimary,
  }) {
    final icon = action.icon;
    final child = icon == null
        ? Text(action.label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              Gap(8 * Theme.of(context).scaling),
              Text(action.label),
            ],
          );

    switch (action.style) {
      case EmptyStateActionStyle.primary:
        return PrimaryButton(onPressed: action.onPressed, child: child);
      case EmptyStateActionStyle.secondary:
        return SecondaryButton(onPressed: action.onPressed, child: child);
      case EmptyStateActionStyle.link:
        return LinkButton(onPressed: action.onPressed, child: child);
    }
  }
}
