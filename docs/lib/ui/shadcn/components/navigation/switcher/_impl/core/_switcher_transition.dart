part of '../../switcher.dart';

class _SwitcherTransition extends MultiChildRenderObjectWidget {
  final double progress;
  final AxisDirection direction;
  final bool absolute;

  const _SwitcherTransition({
    required this.progress,
    required this.direction,
    required this.absolute,
    required super.children,
  });

  @override
  _RenderSwitcherTransition createRenderObject(BuildContext context) {
    return _RenderSwitcherTransition()
      ..progress = progress
      ..direction = direction
      ..absolute = absolute;
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderSwitcherTransition renderObject) {
    if (renderObject.progress != progress ||
        renderObject.direction != direction ||
        renderObject.absolute != absolute) {
      renderObject.progress = progress;
      renderObject.direction = direction;
      renderObject.absolute = absolute;
      renderObject.markNeedsLayout();
    }
  }
}
