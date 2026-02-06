import 'package:flutter/widgets.dart';

T tweenValue<T>(T begin, T end, double t) {
  dynamic beginValue = begin;
  dynamic endValue = end;
  return (beginValue + (endValue - beginValue) * t) as T;
}

/// A tween for animating between two [IconThemeData] values.
class IconThemeDataTween extends Tween<IconThemeData> {
  /// Creates an [IconThemeDataTween].
  IconThemeDataTween({super.begin, super.end});

  @override
  IconThemeData lerp(double t) => IconThemeData.lerp(begin, end, t);
}
