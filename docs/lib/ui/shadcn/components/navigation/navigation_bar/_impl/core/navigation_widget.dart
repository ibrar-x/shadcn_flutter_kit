part of '../../navigation_bar.dart';

class NavigationWidget extends StatelessWidget implements NavigationBarItem {
  /// Optional index for selection tracking.
  final int? index;

  /// Static child widget.
  final Widget? child;

  /// Builder function that receives selection state.
  final NavigationWidgetBuilder? builder;

  /// Creates a navigation widget with a static child.
  ///
  /// Parameters:
  /// - [index] (int?): Selection index
  /// - [child] (Widget, required): Static child widget
  const NavigationWidget({super.key, this.index, required Widget this.child})
      : builder = null;

  /// Creates a navigation widget with a selection-aware builder.
  ///
  /// Parameters:
  /// - [index] (int?): Selection index
  /// - [builder] (NavigationWidgetBuilder, required): Builder receiving selection state
  const NavigationWidget.builder({
    super.key,
    this.index,
    required NavigationWidgetBuilder this.builder,
  }) : child = null;

  @override
  bool get selectable {
    return index == null;
  }

  @override
  Widget build(BuildContext context) {
    var data = Data.maybeOf<NavigationControlData>(context);
    var childData = Data.maybeOf<NavigationChildControlData>(context);
    var index = childData?.index ?? this.index;
    var isSelected = index == data?.selectedIndex;
    return child ?? builder!(context, isSelected);
  }
}
