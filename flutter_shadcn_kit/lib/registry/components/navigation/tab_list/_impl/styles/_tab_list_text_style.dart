part of '../core/tab_list.dart';

class _TabListTextStyle extends StatelessWidget {
  final Widget child;
  final TextStyle Function(ThemeData theme) styleBuilder;

  const _TabListTextStyle({required this.child, required this.styleBuilder});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle.merge(style: styleBuilder(theme), child: child);
  }
}
