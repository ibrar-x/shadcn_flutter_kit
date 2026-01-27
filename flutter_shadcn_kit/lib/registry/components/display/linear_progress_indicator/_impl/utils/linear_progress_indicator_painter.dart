part of '../../linear_progress_indicator.dart';

class _LinearProgressIndicatorProperties {
  final double start;
  final double end;
  final double? start2;
  final double? end2;
  final Color color;
  final Color backgroundColor;
  final bool showSparks;
  final Color sparksColor;
  final double sparksRadius;
  final TextDirection textDirection;

  const _LinearProgressIndicatorProperties({
    required this.start,
    required this.end,
    this.start2,
    this.end2,
    required this.color,
    required this.backgroundColor,
    required this.showSparks,
    required this.sparksColor,
    required this.sparksRadius,
    required this.textDirection,
  });

  static _LinearProgressIndicatorProperties lerp(
    _LinearProgressIndicatorProperties? a,
    _LinearProgressIndicatorProperties? b,
    double t,
  ) {
    final start = a ?? b;
    final end = b ?? a;
    assert(start != null && end != null);
    return _LinearProgressIndicatorProperties(
      start: _lerpDouble(start!.start, end!.start, t)!,
      end: _lerpDouble(start.end, end.end, t)!,
      start2: _lerpDouble(start.start2, end.start2, t),
      end2: _lerpDouble(start.end2, end.end2, t),
      color: Color.lerp(start.color, end.color, t)!,
      backgroundColor:
          Color.lerp(start.backgroundColor, end.backgroundColor, t)!,
      showSparks: end.showSparks,
      sparksColor: Color.lerp(start.sparksColor, end.sparksColor, t)!,
      sparksRadius: _lerpDouble(start.sparksRadius, end.sparksRadius, t)!,
      textDirection: end.textDirection,
    );
  }
}

double? _lerpDouble(double? a, double? b, double t) {
  if (a == null && b == null) {
    return null;
  }
  if (a!.isNaN || b!.isNaN) {
    return double.nan;
  }
  return a + (b - a) * t;
}
