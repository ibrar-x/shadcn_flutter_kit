part of '../../breadcrumb.dart';

/// _ArrowSeparator defines a reusable type for this registry module.
class _ArrowSeparator extends StatelessWidget {
  const _ArrowSeparator();

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
/// Stores `scaling` state/configuration for this implementation.
    final scaling = theme.scaling;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.density.baseGap * scaling * 1.5,
      ),
      child: IconTheme(
        data: IconThemeData(
          color: theme.colorScheme.mutedForeground,
          size: 12 * scaling,
        ),
        child: const Icon(RadixIcons.chevronRight),
      ),
    );
  }
}
