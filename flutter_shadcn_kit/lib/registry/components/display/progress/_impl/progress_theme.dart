part of '../progress.dart';

/// Theme data for [Progress].
class ProgressTheme extends ComponentThemeData {
  final Color? color;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final double? minHeight;

  const ProgressTheme({
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.minHeight,
  });

  ProgressTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<double?>? minHeight,
  }) {
    return ProgressTheme(
      color: color == null ? this.color : color(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      minHeight: minHeight == null ? this.minHeight : minHeight(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProgressTheme &&
        other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius &&
        other.minHeight == minHeight;
  }

  @override
  int get hashCode =>
      Object.hash(color, backgroundColor, borderRadius, minHeight);
}
