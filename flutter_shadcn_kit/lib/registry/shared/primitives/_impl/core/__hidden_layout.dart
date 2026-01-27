part of '../../hidden.dart';


class _HiddenLayout extends SingleChildRenderObjectWidget {
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;
  final TextDirection textDirection;
  final Axis direction;
  final bool reverse;
  final double progress;

  const _HiddenLayout({
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
    required this.textDirection,
    required this.direction,
    required this.reverse,
    required this.progress,
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _HiddenLayoutRender(
      keepCrossAxisSize: keepCrossAxisSize,
      keepMainAxisSize: keepMainAxisSize,
      textDirection: textDirection,
      direction: direction,
      reverse: reverse,
      progress: progress,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _HiddenLayoutRender renderObject) {
    renderObject
      ..keepCrossAxisSize = keepCrossAxisSize
      ..keepMainAxisSize = keepMainAxisSize
      ..textDirection = textDirection
      ..direction = direction
      ..reverse = reverse
      ..progress = progress;
  }
}
