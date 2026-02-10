part of '../../tabs.dart';

class _TabsTextStyle extends StatelessWidget {
  final Widget child;
  final TextStyle Function(ThemeData theme) styleBuilder;

  const _TabsTextStyle({required this.child, required this.styleBuilder});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle.merge(style: styleBuilder(theme), child: child);
  }
}

extension TabsTextStyleExtensions on Widget {
  Widget muted() {
    return _TabsTextStyle(
      child: this,
      styleBuilder: (theme) =>
          TextStyle(color: theme.colorScheme.mutedForeground),
    );
  }

  Widget foreground() {
    return _TabsTextStyle(
      child: this,
      styleBuilder: (theme) => TextStyle(color: theme.colorScheme.foreground),
    );
  }

  Widget small() {
    return _TabsTextStyle(
      child: this,
      styleBuilder: (theme) => theme.typography.small,
    );
  }

  Widget medium() {
    return _TabsTextStyle(
      child: this,
      styleBuilder: (theme) => theme.typography.medium,
    );
  }
}
