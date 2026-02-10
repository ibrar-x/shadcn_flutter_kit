part of '../../flex.dart';

/// Positioned child with optional custom paint order for [Stack].
class Positioned extends widgets.ParentDataWidget<StackParentData> {
  const Positioned({
    super.key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    this.paintOrder,
    required super.child,
  }) : assert(left == null || right == null || width == null),
       assert(top == null || bottom == null || height == null);

  const Positioned.fill({
    super.key,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    this.paintOrder,
    required super.child,
  }) : width = null,
       height = null;

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  /// Higher values paint above lower values.
  final int? paintOrder;

  @override
  void applyParentData(rendering.RenderObject renderObject) {
    assert(renderObject.parentData is StackParentData);
    final parentData = renderObject.parentData! as StackParentData;
    var needsLayout = false;

    if (parentData.left != left) {
      parentData.left = left;
      needsLayout = true;
    }
    if (parentData.top != top) {
      parentData.top = top;
      needsLayout = true;
    }
    if (parentData.right != right) {
      parentData.right = right;
      needsLayout = true;
    }
    if (parentData.bottom != bottom) {
      parentData.bottom = bottom;
      needsLayout = true;
    }
    if (parentData.width != width) {
      parentData.width = width;
      needsLayout = true;
    }
    if (parentData.height != height) {
      parentData.height = height;
      needsLayout = true;
    }
    if (parentData.paintOrder != paintOrder) {
      parentData.paintOrder = paintOrder;
      needsLayout = true;
    }

    if (needsLayout) {
      renderObject.parent?.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Stack;

  @override
  void debugFillProperties(foundation.DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(foundation.DoubleProperty('left', left, defaultValue: null));
    properties.add(foundation.DoubleProperty('top', top, defaultValue: null));
    properties.add(
      foundation.DoubleProperty('right', right, defaultValue: null),
    );
    properties.add(
      foundation.DoubleProperty('bottom', bottom, defaultValue: null),
    );
    properties.add(
      foundation.DoubleProperty('width', width, defaultValue: null),
    );
    properties.add(
      foundation.DoubleProperty('height', height, defaultValue: null),
    );
    properties.add(
      foundation.IntProperty('paintOrder', paintOrder, defaultValue: null),
    );
  }
}
