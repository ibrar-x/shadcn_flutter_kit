part of '../../breadcrumb.dart';

/// _SlashSeparator defines a reusable type for this registry module.
class _SlashSeparator extends StatelessWidget {
  const _SlashSeparator();

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
/// Stores `scaling` state/configuration for this implementation.
    final scaling = theme.scaling;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.density.baseGap * scaling * 0.5,
      ),
      child: const Text('/').small().muted(),
    );
  }
}
