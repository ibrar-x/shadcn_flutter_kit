part of '../../hidden.dart';

class _HiddenLayout extends SingleChildRenderObjectWidget {
  const _HiddenLayout({
    required this.textDirection,
    required this.direction,
    required this.reverse,
    required this.progress,
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
    super.child,
  });

  final TextDirection textDirection;
  final Axis direction;
  final bool reverse;
  final double progress;
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderHiddenLayout(
      textDirection: textDirection,
      direction: direction,
      reverse: reverse,
      progress: progress,
      keepCrossAxisSize: keepCrossAxisSize,
      keepMainAxisSize: keepMainAxisSize,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderHiddenLayout renderObject,
  ) {
    bool needsLayout = false;
    if (renderObject.textDirection != textDirection) {
      renderObject.textDirection = textDirection;
      needsLayout = true;
    }
    if (renderObject.direction != direction) {
      renderObject.direction = direction;
      needsLayout = true;
    }
    if (renderObject.reverse != reverse) {
      renderObject.reverse = reverse;
      needsLayout = true;
    }
    if (renderObject.progress != progress) {
      renderObject.progress = progress;
      needsLayout = true;
    }
    if (renderObject.keepCrossAxisSize != keepCrossAxisSize) {
      renderObject.keepCrossAxisSize = keepCrossAxisSize;
      needsLayout = true;
    }
    if (renderObject.keepMainAxisSize != keepMainAxisSize) {
      renderObject.keepMainAxisSize = keepMainAxisSize;
      needsLayout = true;
    }
    if (needsLayout) {
      renderObject.markNeedsLayout();
    }
  }
}

