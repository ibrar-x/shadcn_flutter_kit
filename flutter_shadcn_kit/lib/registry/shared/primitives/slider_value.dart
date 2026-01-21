import 'dart:ui';

/// Represents a single-thumb or range slider value.
class SliderValue {
  final double? _start;
  final double _end;

  const SliderValue.single(double value)
      : _start = null,
        _end = value;

  const SliderValue.ranged(double start, double end)
      : _start = start,
        _end = end;

  bool get isRanged => _start != null;
  double get start => _start ?? _end;
  double get end => _end;
  double get value => _end;

  static SliderValue? lerp(SliderValue? a, SliderValue? b, double t) {
    if (a == null || b == null) return null;
    if (a.isRanged && b.isRanged) {
      return SliderValue.ranged(
        lerpDouble(a.start, b.start, t)!,
        lerpDouble(a.end, b.end, t)!,
      );
    } else if (!a.isRanged && !b.isRanged) {
      return SliderValue.single(lerpDouble(a.value, b.value, t)!);
    }
    return null;
  }

  SliderValue roundToDivisions(int divisions) {
    if (!isRanged) {
      return SliderValue.single((_end * divisions).round() / divisions);
    }
    return SliderValue.ranged(
      (_start! * divisions).round() / divisions,
      (_end * divisions).round() / divisions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SliderValue &&
        other._start == _start &&
        other._end == _end;
  }

  @override
  int get hashCode => Object.hash(_start, _end);
}
