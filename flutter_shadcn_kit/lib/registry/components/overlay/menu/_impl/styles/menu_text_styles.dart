part of '../../menu.dart';

class _MenuTextStyle extends StatelessWidget {
  final Widget child;
  final TextStyle Function(ThemeData theme) styleBuilder;

  const _MenuTextStyle({required this.child, required this.styleBuilder});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle.merge(style: styleBuilder(theme), child: child);
  }
}

extension MenuTextStyleExtensions on Widget {
  Widget xSmall() {
    return _MenuTextStyle(
      child: this,
      styleBuilder: (theme) => theme.typography.xSmall,
    );
  }

  Widget muted() {
    return _MenuTextStyle(
      child: this,
      styleBuilder: (theme) =>
          TextStyle(color: theme.colorScheme.mutedForeground),
    );
  }

  Widget semiBold() {
    return _MenuTextStyle(
      child: this,
      styleBuilder: (theme) => theme.typography.semiBold,
    );
  }

  Widget medium() {
    return _MenuTextStyle(
      child: this,
      styleBuilder: (theme) => theme.typography.medium,
    );
  }

  Widget normal() {
    return _MenuTextStyle(
      child: this,
      styleBuilder: (theme) => theme.typography.normal,
    );
  }
}

extension MenuIconStyleExtensions on Widget {
  Widget iconSmall() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return IconTheme(data: theme.iconTheme.small, child: this);
      },
    );
  }
}
