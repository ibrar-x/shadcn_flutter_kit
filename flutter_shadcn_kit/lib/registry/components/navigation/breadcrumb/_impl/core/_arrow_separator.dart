part of '../../breadcrumb.dart';

class _ArrowSeparator extends StatelessWidget {
  const _ArrowSeparator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
