part of '../../resizable.dart';

class _ResizableLayout extends MultiChildRenderObjectWidget {
  final Axis direction;
  final _ResizableLayoutCallback onLayout;

  const _ResizableLayout({
    required this.direction,
    required super.children,
    required this.onLayout,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderResizableLayout(direction, onLayout);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderResizableLayout renderObject,
  ) {
    bool needsLayout = false;
    if (renderObject.direction != direction) {
      renderObject.direction = direction;
      needsLayout = true;
    }
    if (renderObject.onLayout != onLayout) {
      renderObject.onLayout = onLayout;
      needsLayout = true;
    }
    if (needsLayout) {
      renderObject.markNeedsLayout();
    }
  }
}
