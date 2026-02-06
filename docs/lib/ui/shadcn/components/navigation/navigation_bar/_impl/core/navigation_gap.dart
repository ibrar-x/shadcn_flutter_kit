part of '../../navigation_bar.dart';

class NavigationGap extends StatelessWidget implements NavigationBarItem {
  /// Size of the gap in logical pixels.
  final double gap;

  /// Creates a navigation gap.
  ///
  /// Parameters:
  /// - [gap] (double, required): Gap size in logical pixels
  const NavigationGap(this.gap, {super.key});

  @override
  bool get selectable => false;

  /// Builds the gap widget for box-based navigation containers.
  ///
  /// Returns a [Gap] widget with the specified gap size.
  Widget buildBox(BuildContext context) {
    return Gap(gap);
  }

  /// Builds the gap widget for sliver-based navigation containers.
  ///
  /// Returns a [SliverGap] widget with the specified gap size.
  Widget buildSliver(BuildContext context) {
    return SliverGap(gap);
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context);
    }
    return buildBox(context);
  }
}
