part of '../../context_menu.dart';

/// _ContextMenuScope defines a reusable type for this registry module.
class _ContextMenuScope extends StatelessWidget {
/// Stores `child` state/configuration for this implementation.
  final Widget child;

  const _ContextMenuScope({required this.child});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedDefaultTextStyle(
      style: theme.typography.sans.copyWith(
        color: theme.colorScheme.foreground,
      ),
      duration: kDefaultDuration,
      child: IconTheme(
        data: IconThemeData(color: theme.colorScheme.foreground),
        child: child,
      ),
    );
  }
}
