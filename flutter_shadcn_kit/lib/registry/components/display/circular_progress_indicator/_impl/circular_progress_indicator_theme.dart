part of '../circular_progress_indicator.dart';

/// Theme data for [CircularProgressIndicator].
class CircularProgressIndicatorTheme extends ComponentThemeData {
  final Color? color;
  final Color? backgroundColor;
  final double? size;
  final double? strokeWidth;

  const CircularProgressIndicatorTheme({
    this.color,
    this.backgroundColor,
    this.size,
    this.strokeWidth,
  });

  CircularProgressIndicatorTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<double?>? size,
    ValueGetter<double?>? strokeWidth,
  }) {
    return CircularProgressIndicatorTheme(
      color: color == null ? this.color : color(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      size: size == null ? this.size : size(),
      strokeWidth: strokeWidth == null ? this.strokeWidth : strokeWidth(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CircularProgressIndicatorTheme &&
        other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.size == size &&
        other.strokeWidth == strokeWidth;
  }

  @override
  int get hashCode => Object.hash(color, backgroundColor, size, strokeWidth);
}
