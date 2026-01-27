part of '../../timeline_animation.dart';

class Transformers {
  const Transformers._();

  static int? typeInt(int? a, int? b, double t) {
    if (a == null || b == null) return null;
    return (a + (b - a) * t).round();
  }

  static double? typeDouble(double? a, double? b, double t) {
    if (a == null || b == null) return null;
    return lerpDouble(a, b, t);
  }

  static Color? typeColor(Color? a, Color? b, double t) {
    return Color.lerp(a, b, t);
  }

  static Offset? typeOffset(Offset? a, Offset? b, double t) {
    return Offset.lerp(a, b, t);
  }

  static Size? typeSize(Size? a, Size? b, double t) {
    return Size.lerp(a, b, t);
  }

  static Rect? typeRect(Rect? a, Rect? b, double t) {
    return Rect.lerp(a, b, t);
  }
}

/// Defines a segment in a timeline animation.
