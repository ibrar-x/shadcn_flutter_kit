part of '../../select.dart';

/// An empty select item delegate that renders no items.
class EmptySelectItem extends SelectItemDelegate {
  /// Creates an empty select item.
  const EmptySelectItem();

  /// Builds the widget tree for this component state.
  @override
  Widget? build(BuildContext context, int index) => null;

  /// Field storing `estimatedChildCount` for this form implementation.
  @override
  int get estimatedChildCount => 0;

  /// Performs `shouldRebuild` logic for this form component.
  @override
  bool shouldRebuild(covariant EmptySelectItem oldDelegate) {
    return false;
  }
}
