part of '../../breadcrumb.dart';

class _SlashSeparator extends StatelessWidget {
  const _SlashSeparator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.density.baseGap * scaling * 0.5,
      ),
      child: const Text('/').small().muted(),
    );
  }
}
