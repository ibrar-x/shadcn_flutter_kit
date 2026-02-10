part of '../../flex.dart';

/// Patched flex render object with paint-order sorting support.
class RenderFlex extends rendering.RenderFlex with PaintOrderMixin {
  RenderFlex({
    super.children,
    super.direction,
    super.mainAxisSize,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.clipBehavior,
    super.spacing,
  });

  bool _hasOverflow = false;

  @override
  rendering.RenderBox? get paintOrderFirstChild => firstChild;

  @override
  Clip? get optionalClipBehavior => clipBehavior;

  @override
  void setupParentData(rendering.RenderBox child) {
    if (child.parentData is! FlexParentData) {
      child.parentData = FlexParentData();
    }
  }

  @override
  void performLayout() {
    super.performLayout();
    buildSortedLinkedList();
    _hasOverflow = _checkOverflow();
  }

  bool _checkOverflow() {
    rendering.RenderBox? child = firstChild;
    while (child != null) {
      final parentData = child.parentData! as FlexParentData;
      final childRect = parentData.offset & child.size;
      if (childRect.right > size.width + 0.001 ||
          childRect.bottom > size.height + 0.001) {
        return true;
      }
      child = parentData.nextSibling;
    }
    return false;
  }

  @override
  void paint(rendering.PaintingContext context, Offset offset) {
    if (!_hasOverflow) {
      paintSorted(context, offset);
      return;
    }

    if (size.isEmpty) {
      return;
    }

    context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & size,
      paintSorted,
      clipBehavior: clipBehavior,
    );
  }

  @override
  bool hitTestChildren(
    rendering.BoxHitTestResult result, {
    required Offset position,
  }) {
    return hitTestSortedChildren(result, position: position);
  }
}
