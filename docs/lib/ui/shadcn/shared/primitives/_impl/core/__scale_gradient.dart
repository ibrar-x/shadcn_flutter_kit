part of '../../fade_scroll.dart';


class _ScaleGradient extends GradientTransform {
  final Offset scale;

  const _ScaleGradient(this.scale);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final center = bounds.center;
    final dx = center.dx * (1 - scale.dx);
    final dy = center.dy * (1 - scale.dy);
    return Matrix4.identity()
      ..translateByDouble(dx, dy, 0, 1)
      ..scaleByDouble(scale.dx, scale.dy, 1, 1)
      ..translateByDouble(-dx, -dy, 0, 1);
  }
}
