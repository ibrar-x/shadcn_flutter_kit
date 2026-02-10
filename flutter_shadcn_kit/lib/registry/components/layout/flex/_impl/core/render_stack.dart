part of '../../flex.dart';

/// Patched stack render object with paint-order sorting support.
class RenderStack extends rendering.RenderStack with PaintOrderMixin {
  RenderStack({
    super.children,
    super.alignment,
    super.textDirection,
    super.fit,
    super.clipBehavior,
  });

  @override
  rendering.RenderBox? get paintOrderFirstChild => firstChild;

  @override
  Clip? get optionalClipBehavior => clipBehavior;

  @override
  void setupParentData(rendering.RenderBox child) {
    if (child.parentData is! StackParentData) {
      child.parentData = StackParentData();
    }
  }

  @override
  void performLayout() {
    super.performLayout();
    buildSortedLinkedList();
  }

  @override
  void paintStack(rendering.PaintingContext context, Offset offset) {
    paintSorted(context, offset);
  }

  @override
  bool hitTestChildren(
    rendering.BoxHitTestResult result, {
    required Offset position,
  }) {
    return hitTestSortedChildren(result, position: position);
  }
}
