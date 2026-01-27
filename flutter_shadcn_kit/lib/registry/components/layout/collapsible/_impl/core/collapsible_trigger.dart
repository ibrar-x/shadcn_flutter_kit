part of '../../collapsible.dart';

/// Interactive trigger row used by [Collapsible].
class CollapsibleTrigger extends StatelessWidget {
  /// Creates a trigger with [child] content.
  const CollapsibleTrigger({super.key, required this.child});

  /// Content shown alongside the indicator icon.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<CollapsibleTheme>(context);
    final state = Data.of<CollapsibleStateData>(context);
    final scaling = theme.scaling;

    final padding = compTheme?.padding ?? 16 * scaling;
    final iconGap = compTheme?.iconGap ?? 16 * scaling;
    final iconExpanded = compTheme?.iconExpanded ?? Icons.unfold_less;
    final iconCollapsed = compTheme?.iconCollapsed ?? Icons.unfold_more;

    final iconTheme = IconThemeData(
      size: theme.iconTheme.xSmall.size ??
          theme.iconTheme.small.size ??
          16 * scaling,
      color: theme.colorScheme.mutedForeground,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: child.small().semiBold(),
        ),
        Gap(iconGap),
        GhostButton(
          onPressed: state.handleTap,
          child: IconTheme(
            data: iconTheme,
            child: Icon(
              state.isExpanded ? iconExpanded : iconCollapsed,
            ),
          ),
        ),
      ],
    ).withPadding(horizontal: padding);
  }
}
