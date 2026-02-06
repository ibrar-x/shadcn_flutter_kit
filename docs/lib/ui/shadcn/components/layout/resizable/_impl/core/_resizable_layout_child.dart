part of '../../resizable.dart';

class _ResizableLayoutChild
    extends ParentDataWidget<_ResizableLayoutParentData> {
  final int? index;
  final bool? isDragger;
  final bool? isDivider;
  final double? size;
  final double? flex;

  const _ResizableLayoutChild({
    this.index,
    this.isDragger,
    this.isDivider,
    this.size,
    this.flex,
    required super.child,
  });

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as _ResizableLayoutParentData;
    bool needsLayout = false;

    if (parentData.index != index) {
      parentData.index = index;
      needsLayout = true;
    }

    if (parentData.isDragger != isDragger) {
      parentData.isDragger = isDragger;
      needsLayout = true;
    }

    if (parentData.isDivider != isDivider) {
      parentData.isDivider = isDivider;
      needsLayout = true;
    }

    if (parentData.size != size) {
      parentData.size = size;
      needsLayout = true;
    }

    if (parentData.flex != flex) {
      parentData.flex = flex;
      needsLayout = true;
    }

    if (needsLayout) {
      final targetParent = renderObject.parent;
      targetParent?.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => _ResizableLayout;
}
