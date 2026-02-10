part of '../../context_menu.dart';

class _ContextMenuScope extends StatelessWidget {
  final Widget child;

  const _ContextMenuScope({required this.child});

  @override
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
