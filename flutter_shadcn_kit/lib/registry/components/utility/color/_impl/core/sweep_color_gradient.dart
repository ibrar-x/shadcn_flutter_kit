part of '../../color.dart';

/// A sweep (angular/conical) gradient for color values.
///
/// Creates a gradient that sweeps around a center point.
class SweepColorGradient extends ColorGradient {
  /// The color stops defining the gradient.
  final List<ColorStop> colors;

  /// How the gradient tiles beyond its bounds.
  final TileMode tileMode;

  /// The center point of the gradient.
  final AlignmentGeometry center;

  /// The starting angle in radians.
  final double startAngle;

  /// The ending angle in radians.
  final double endAngle;

  /// Creates a sweep color gradient.
  const SweepColorGradient({
    required this.colors,
    this.tileMode = TileMode.clamp,
    this.center = Alignment.center,
    this.startAngle = 0.0,
    this.endAngle = pi * 2,
  });

  @override
  SweepColorGradient copyWith({
    List<ColorStop>? colors,
    TileMode? tileMode,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
  }) {
    return SweepColorGradient(
      colors: colors ?? this.colors,
      tileMode: tileMode ?? this.tileMode,
      center: center ?? this.center,
      startAngle: startAngle ?? this.startAngle,
      endAngle: endAngle ?? this.endAngle,
    );
  }

  @override
  SweepColorGradient changeColorAt(int index, ColorDerivative color) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: color,
      position: newColors[index].position,
    );
    return copyWith(colors: newColors);
  }

  @override
  SweepColorGradient changePositionAt(int index, double position) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: newColors[index].color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  SweepColorGradient changeColorAndPositionAt(
    int index,
    ColorDerivative color,
    double position,
  ) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(color: color, position: position);
    return copyWith(colors: newColors);
  }

  @override
  ({SweepColorGradient gradient, int index}) insertColorAt(
    ColorDerivative color,
    Offset position,
    Size size,
    TextDirection textDirection,
  ) {
    Alignment alignCenter = center.resolve(textDirection);
    final px = (position.dx / size.width) * 2 - 1;
    final py = (position.dy / size.height) * 2 - 1;
    final dx = px - alignCenter.x;
    final dy = py - alignCenter.y;
    final angle = atan2(dy, dx);
    double normalizedAngle = angle;
    if (normalizedAngle < startAngle) {
      normalizedAngle += pi * 2;
    }
    final totalAngle = endAngle - startAngle;
    final pos = ((normalizedAngle - startAngle) / totalAngle).clamp(0.0, 1.0);
    List<ColorStop> newColors = List.from(colors);
    int insertIndex = 0;
    for (int i = 0; i < newColors.length; i++) {
      if (newColors[i].position < pos) {
        insertIndex = i + 1;
      }
    }
    newColors.insert(insertIndex, ColorStop(color: color, position: pos));
    return (gradient: copyWith(colors: newColors), index: insertIndex);
  }

  @override
  SweepGradient toGradient() {
    return SweepGradient(
      colors: colors.map((e) => e.color.toColor()).toList(),
      stops: colors.map((e) => e.position).toList(),
      center: center,
      startAngle: startAngle,
      endAngle: endAngle,
      tileMode: tileMode,
    );
  }
}
