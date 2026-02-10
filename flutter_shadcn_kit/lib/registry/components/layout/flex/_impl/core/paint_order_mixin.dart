part of '../../flex.dart';

/// Shared sort/paint/hit-test behavior for render objects with paint order.
mixin PaintOrderMixin on rendering.RenderBox {
  rendering.RenderBox? firstSortedChild;
  rendering.RenderBox? lastSortedChild;

  /// The first child in natural sibling order.
  rendering.RenderBox? get paintOrderFirstChild;

  /// Optional clip behavior for sorted painting.
  Clip? get optionalClipBehavior => null;

  /// Rebuilds paint-order linked list. Stable for equal paint orders.
  void buildSortedLinkedList() {
    final first = paintOrderFirstChild;
    if (first == null) {
      firstSortedChild = null;
      lastSortedChild = null;
      return;
    }

    rendering.RenderBox? child = first;
    rendering.RenderBox? prev;
    var needsSort = false;
    var childCount = 0;

    while (child != null) {
      final parentData = child.parentData! as PaintOrderParentDataMixin;
      final order = parentData.paintOrder;
      parentData.paintIndex = order ?? 0;
      if (order != null) {
        needsSort = true;
      }
      parentData.previousSortedSibling = prev;
      if (prev != null) {
        (prev.parentData! as PaintOrderParentDataMixin).nextSortedSibling =
            child;
      }
      prev = child;
      child = parentData.nextSibling;
      childCount++;
    }

    if (prev != null) {
      (prev.parentData! as PaintOrderParentDataMixin).nextSortedSibling = null;
    }

    firstSortedChild = first;
    lastSortedChild = prev;

    if (!needsSort) {
      return;
    }

    firstSortedChild = _mergeSort(first, childCount);

    rendering.RenderBox? current = firstSortedChild;
    prev = null;
    while (current != null) {
      final parentData = current.parentData! as PaintOrderParentDataMixin;
      parentData.previousSortedSibling = prev;
      prev = current;
      current = parentData.nextSortedSibling;
    }
    lastSortedChild = prev;
  }

  rendering.RenderBox? _mergeSort(rendering.RenderBox? head, int length) {
    if (head == null || length <= 1) {
      return head;
    }

    final mid = length ~/ 2;
    rendering.RenderBox? current = head;
    for (var i = 0; i < mid - 1 && current != null; i++) {
      current =
          (current.parentData! as PaintOrderParentDataMixin).nextSortedSibling;
    }

    rendering.RenderBox? secondHalf;
    if (current != null) {
      final parentData = current.parentData! as PaintOrderParentDataMixin;
      secondHalf = parentData.nextSortedSibling;
      parentData.nextSortedSibling = null;
    }

    final left = _mergeSort(head, mid);
    final right = _mergeSort(secondHalf, length - mid);

    return _merge(left, right);
  }

  rendering.RenderBox? _merge(
    rendering.RenderBox? left,
    rendering.RenderBox? right,
  ) {
    if (left == null) return right;
    if (right == null) return left;

    rendering.RenderBox? head;
    rendering.RenderBox? tail;

    final leftData = left.parentData! as PaintOrderParentDataMixin;
    final rightData = right.parentData! as PaintOrderParentDataMixin;
    if (leftData.paintIndex <= rightData.paintIndex) {
      head = left;
      left = leftData.nextSortedSibling;
    } else {
      head = right;
      right = rightData.nextSortedSibling;
    }
    tail = head;

    while (left != null && right != null) {
      final leftParentData = left.parentData! as PaintOrderParentDataMixin;
      final rightParentData = right.parentData! as PaintOrderParentDataMixin;

      if (leftParentData.paintIndex <= rightParentData.paintIndex) {
        (tail!.parentData! as PaintOrderParentDataMixin).nextSortedSibling =
            left;
        tail = left;
        left = leftParentData.nextSortedSibling;
      } else {
        (tail!.parentData! as PaintOrderParentDataMixin).nextSortedSibling =
            right;
        tail = right;
        right = rightParentData.nextSortedSibling;
      }
    }

    (tail!.parentData! as PaintOrderParentDataMixin).nextSortedSibling =
        left ?? right;
    return head;
  }

  /// Paint children from back to front.
  void paintSorted(rendering.PaintingContext context, Offset offset) {
    final clipBehavior = optionalClipBehavior;
    if (clipBehavior != null && clipBehavior != Clip.none) {
      context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        _paintSorted,
        clipBehavior: clipBehavior,
      );
    } else {
      _paintSorted(context, offset);
    }
  }

  void _paintSorted(rendering.PaintingContext context, Offset offset) {
    rendering.RenderBox? child = firstSortedChild;
    while (child != null) {
      final parentData = child.parentData! as PaintOrderParentDataMixin;
      context.paintChild(child, parentData.offset + offset);
      child = parentData.nextSortedSibling;
    }
  }

  /// Hit-test from front to back.
  bool hitTestSortedChildren(
    rendering.BoxHitTestResult result, {
    required Offset position,
  }) {
    rendering.RenderBox? child = lastSortedChild;
    while (child != null) {
      final parentData = child.parentData! as PaintOrderParentDataMixin;
      final isHit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (rendering.BoxHitTestResult result, Offset transformed) {
          return child!.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
      child = parentData.previousSortedSibling;
    }
    return false;
  }
}
