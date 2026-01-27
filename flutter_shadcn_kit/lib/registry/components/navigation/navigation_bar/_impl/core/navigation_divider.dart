part of '../../navigation_bar.dart';

class NavigationDivider extends StatelessWidget implements NavigationBarItem {
  /// Optional thickness of the divider line.
  final double? thickness;

  /// Optional color for the divider.
  final Color? color;

  /// Creates a navigation divider.
  ///
  /// Parameters:
  /// - [thickness] (double?): Line thickness
  /// - [color] (Color?): Divider color
  const NavigationDivider({super.key, this.thickness, this.color});

  @override
  bool get selectable => false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final data = Data.maybeOf<NavigationControlData>(context);
    final parentPadding = data?.parentPadding ?? EdgeInsets.zero;
    final direction = data?.direction ?? Axis.vertical;
    Widget child;
    if (direction == Axis.vertical) {
      child = Divider(
        indent: -parentPadding.left,
        endIndent: -parentPadding.right,
        thickness: thickness ?? (1 * scaling),
        color: color ?? theme.colorScheme.muted,
      );
    } else {
      child = VerticalDivider(
        indent: -parentPadding.top,
        endIndent: -parentPadding.bottom,
        thickness: thickness ?? (1 * scaling),
        color: color ?? theme.colorScheme.muted,
      );
    }
    child = NavigationPadding(child: child);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: direction == Axis.vertical
              ? EdgeInsets.symmetric(vertical: 8 * scaling)
              : EdgeInsets.symmetric(horizontal: 8 * scaling),
          child: child,
        ),
      );
    }
    return Padding(
      padding: direction == Axis.vertical
          ? EdgeInsets.symmetric(vertical: 4 * scaling)
          : EdgeInsets.symmetric(horizontal: 4 * scaling),
      child: child,
    );
  }
}
