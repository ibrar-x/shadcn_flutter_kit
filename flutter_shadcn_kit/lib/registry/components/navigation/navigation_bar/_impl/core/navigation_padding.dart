part of '../../navigation_bar.dart';

class NavigationPadding extends StatelessWidget {
  /// Child widget to wrap with padding.
  final Widget child;

  /// Creates a navigation padding wrapper.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Widget to wrap
  const NavigationPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final parentData = Data.maybeOf<NavigationControlData>(context);
    final childData = Data.maybeOf<NavigationChildControlData>(context);
    if (parentData != null && childData != null) {
      final direction = parentData.direction;
      final gap = parentData.spacing / 2;
      final index = childData.index;
      final count = parentData.childCount;
      final isFirst = index == 0;
      final isLast = index == count - 1;
      return Padding(
        padding: direction == Axis.vertical
            ? EdgeInsets.only(top: isFirst ? 0 : gap, bottom: isLast ? 0 : gap)
            : EdgeInsets.only(left: isFirst ? 0 : gap, right: isLast ? 0 : gap),
        child: child,
      );
    }
    return child;
  }
}
