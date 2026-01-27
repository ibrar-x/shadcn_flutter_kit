part of '../../select.dart';

/// An empty select item delegate that renders no items.
class EmptySelectItem extends SelectItemDelegate {
  /// Creates an empty select item.
  const EmptySelectItem();

  @override
  Widget? build(BuildContext context, int index) => null;

  @override
  int get estimatedChildCount => 0;

  @override
  bool shouldRebuild(covariant EmptySelectItem oldDelegate) {
    return false;
  }
}
