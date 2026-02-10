part of '../../resizable.dart';

class _RenderResizableLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ResizableLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ResizableLayoutParentData> {
  Axis direction;
  _ResizableLayoutCallback onLayout;

  _RenderResizableLayout(this.direction, this.onLayout);

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _ResizableLayoutParentData) {
      child.parentData = _ResizableLayoutParentData();
    }
  }

  double _getSizeExtent(Size size) {
    return direction == Axis.horizontal ? size.width : size.height;
  }

  Offset _createOffset(double main, double cross) {
    return direction == Axis.horizontal
        ? Offset(main, cross)
        : Offset(cross, main);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void performLayout() {
    final constraints = this.constraints;

    double mainOffset = 0;

    double intrinsicCross = 0;
    bool hasInfiniteCross = direction == Axis.horizontal
        ? !constraints.hasBoundedHeight
        : !constraints.hasBoundedWidth;
    if (hasInfiniteCross) {
      RenderBox? child = firstChild;
      while (child != null) {
        final childParentData = child.parentData as _ResizableLayoutParentData;
        if (childParentData.isDragger != true &&
            childParentData.index == null) {
          if (direction == Axis.horizontal) {
            intrinsicCross = max(
              intrinsicCross,
              child.getMaxIntrinsicHeight(double.infinity),
            );
          } else {
            intrinsicCross = max(
              intrinsicCross,
              child.getMaxIntrinsicWidth(double.infinity),
            );
          }
        }
        child = childParentData.nextSibling;
      }
    } else {
      intrinsicCross = direction == Axis.horizontal
          ? constraints.maxHeight
          : constraints.maxWidth;
    }

    // lay out the dividers
    double flexCount = 0;
    List<double> dividerSizes = [];
    RenderBox? child = firstChild;
    double panelSize = 0;
    List<double> dividerOffsets = [];
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;
      if (childParentData.isDragger != true && childParentData.index == null) {
        if (childParentData.isDivider == true) {
          BoxConstraints childConstraints;
          if (direction == Axis.horizontal) {
            childConstraints = BoxConstraints(
              minWidth: 0,
              maxWidth: constraints.maxWidth,
              minHeight: intrinsicCross,
              maxHeight: intrinsicCross,
            );
          } else {
            childConstraints = BoxConstraints(
              minWidth: intrinsicCross,
              maxWidth: intrinsicCross,
              minHeight: 0,
              maxHeight: constraints.maxHeight,
            );
          }
          child.layout(childConstraints, parentUsesSize: true);
          Size childSize = child.size;
          var sizeExtent = _getSizeExtent(childSize);
          dividerSizes.add(sizeExtent);
          mainOffset += sizeExtent;
        } else if (childParentData.flex != null) {
          flexCount += childParentData.flex!;
        } else if (childParentData.size != null) {
          panelSize += childParentData.size!;
        }
      }
      child = childParentData.nextSibling;
    }
    double totalDividerSize = mainOffset;
    mainOffset = 0;
    // lay out the panes
    child = firstChild;
    // List<double> sizes = [];
    double parentSize = direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    double remainingSpace = parentSize - (panelSize + totalDividerSize);
    double flexSpace = remainingSpace / flexCount;
    onLayout(flexSpace, flexCount);
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;
      if (childParentData.isDragger != true && childParentData.index == null) {
        if (childParentData.isDivider != true) {
          BoxConstraints childConstraints;
          double childExtent;
          if (childParentData.flex != null) {
            childExtent = flexSpace * childParentData.flex!;
          } else {
            childExtent = childParentData.size!;
          }
          if (direction == Axis.horizontal) {
            childConstraints = BoxConstraints(
              minWidth: childExtent,
              maxWidth: childExtent,
              minHeight: intrinsicCross,
              maxHeight: intrinsicCross,
            );
          } else {
            childConstraints = BoxConstraints(
              minWidth: intrinsicCross,
              maxWidth: intrinsicCross,
              minHeight: childExtent,
              maxHeight: childExtent,
            );
          }
          child.layout(childConstraints, parentUsesSize: true);
          Size childSize = child.size;
          var sizeExtent = _getSizeExtent(childSize);
          // sizes.add(sizeExtent);
          childParentData.offset = _createOffset(mainOffset, 0);
          mainOffset += sizeExtent;
        } else {
          childParentData.offset = _createOffset(mainOffset, 0);
          dividerOffsets.add(mainOffset + _getSizeExtent(child.size) / 2);
          mainOffset += _getSizeExtent(child.size);
        }
      }
      child = childParentData.nextSibling;
    }

    // layout the rest
    child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;
      if (childParentData.isDragger == true || childParentData.index != null) {
        // total offset = sum of sizes from 0 to index
        double minExtent = 0;
        if (childParentData.index != null) {
          minExtent = dividerSizes[childParentData.index!];
        }
        double intrinsicExtent = 0;
        if (direction == Axis.horizontal) {
          intrinsicExtent = child.getMaxIntrinsicWidth(double.infinity);
        } else {
          intrinsicExtent = child.getMaxIntrinsicHeight(double.infinity);
        }
        minExtent += intrinsicExtent;
        BoxConstraints draggerConstraints;
        if (direction == Axis.horizontal) {
          draggerConstraints = BoxConstraints(
            minWidth: minExtent,
            maxWidth: double.infinity,
            minHeight: intrinsicCross,
            maxHeight: intrinsicCross,
          );
        } else {
          draggerConstraints = BoxConstraints(
            minWidth: intrinsicCross,
            maxWidth: intrinsicCross,
            minHeight: minExtent,
            maxHeight: double.infinity,
          );
        }
        child.layout(draggerConstraints, parentUsesSize: true);
        Size draggerSize = child.size;
        // align at center
        var sizeExtent = _getSizeExtent(draggerSize);
        childParentData.offset = _createOffset(
          dividerOffsets[childParentData.index!] - sizeExtent / 2,
          0,
        );
        // childParentData.offset =
        //     _createOffset(draggerOffset - sizeExtent / 2 + dividerOffset, 0);
        // dividerOffset += sizeExtent;
      }
      child = childParentData.nextSibling;
    }

    Size size;
    if (direction == Axis.horizontal) {
      size = Size(mainOffset, intrinsicCross);
    } else {
      size = Size(intrinsicCross, mainOffset);
    }
    this.size = constraints.constrain(size);
  }

  /// Helper method to compute intrinsic sizes based on children
  double _computeIntrinsicMainSize(double extent) {
    double totalSize = 0;

    // First pass: calculate fixed sizes and total flex
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;

      if (childParentData.isDragger != true && childParentData.index == null) {
        if (childParentData.isDivider == true) {
          // Add divider intrinsic size
          if (direction == Axis.horizontal) {
            totalSize += child.getMinIntrinsicWidth(extent);
          } else {
            totalSize += child.getMinIntrinsicHeight(extent);
          }
        } else if (childParentData.size != null) {
          // Fixed size pane
          totalSize += childParentData.size!;
        } else if (childParentData.flex != null) {
          // Add minimum intrinsic size for flex children
          if (direction == Axis.horizontal) {
            totalSize += child.getMinIntrinsicWidth(extent);
          } else {
            totalSize += child.getMinIntrinsicHeight(extent);
          }
        }
      }

      child = childParentData.nextSibling;
    }

    return totalSize;
  }

  double _computeIntrinsicCrossSize(double extent) {
    double maxCrossSize = 0;

    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;

      if (childParentData.isDragger != true && childParentData.index == null) {
        double childCrossSize;
        if (direction == Axis.horizontal) {
          childCrossSize = child.getMinIntrinsicHeight(extent);
        } else {
          childCrossSize = child.getMinIntrinsicWidth(extent);
        }
        maxCrossSize = max(maxCrossSize, childCrossSize);
      }

      child = childParentData.nextSibling;
    }

    return maxCrossSize;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (direction == Axis.horizontal) {
      return _computeIntrinsicMainSize(height);
    } else {
      return _computeIntrinsicCrossSize(height);
    }
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (direction == Axis.horizontal) {
      return _computeIntrinsicMainSize(height);
    } else {
      return _computeIntrinsicCrossSize(height);
    }
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (direction == Axis.vertical) {
      return _computeIntrinsicMainSize(width);
    } else {
      return _computeIntrinsicCrossSize(width);
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (direction == Axis.vertical) {
      return _computeIntrinsicMainSize(width);
    } else {
      return _computeIntrinsicCrossSize(width);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    double mainOffset = 0;

    // Calculate cross axis size
    double intrinsicCross = 0;
    bool hasInfiniteCross = direction == Axis.horizontal
        ? !constraints.hasBoundedHeight
        : !constraints.hasBoundedWidth;

    if (hasInfiniteCross) {
      intrinsicCross = direction == Axis.horizontal
          ? computeMinIntrinsicHeight(constraints.maxWidth)
          : computeMinIntrinsicWidth(constraints.maxHeight);
    } else {
      intrinsicCross = direction == Axis.horizontal
          ? constraints.maxHeight
          : constraints.maxWidth;
    }

    // Calculate main axis sizes - similar to performLayout but without actual layout
    double flexCount = 0;
    double panelSize = 0;
    double totalDividerSize = 0;

    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as _ResizableLayoutParentData;

      if (childParentData.isDragger != true && childParentData.index == null) {
        if (childParentData.isDivider == true) {
          // Calculate divider size
          Size childSize;
          if (direction == Axis.horizontal) {
            childSize = child.getDryLayout(
              BoxConstraints(
                minWidth: 0,
                maxWidth: constraints.maxWidth,
                minHeight: intrinsicCross,
                maxHeight: intrinsicCross,
              ),
            );
          } else {
            childSize = child.getDryLayout(
              BoxConstraints(
                minWidth: intrinsicCross,
                maxWidth: intrinsicCross,
                minHeight: 0,
                maxHeight: constraints.maxHeight,
              ),
            );
          }
          totalDividerSize += _getSizeExtent(childSize);
        } else if (childParentData.flex != null) {
          flexCount += childParentData.flex!;
        } else if (childParentData.size != null) {
          panelSize += childParentData.size!;
        }
      }

      child = childParentData.nextSibling;
    }

    // Calculate remaining space for flex children
    double parentSize = direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    double remainingSpace = parentSize - (panelSize + totalDividerSize);
    double flexSpace = flexCount > 0 ? remainingSpace / flexCount : 0;

    // Calculate total main axis size
    mainOffset = panelSize + totalDividerSize + (flexSpace * flexCount);

    Size size;
    if (direction == Axis.horizontal) {
      size = Size(mainOffset, intrinsicCross);
    } else {
      size = Size(intrinsicCross, mainOffset);
    }

    return constraints.constrain(size);
  }
}
