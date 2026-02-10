part of '../../spinner.dart';

/// Theme data for [Spinner].
class SpinnerTheme extends ComponentThemeData {
  final Color? color;
  final double? size;

  const SpinnerTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.color,
    this.size,
  });

  SpinnerTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<double?>? size,
  }) {
    return SpinnerTheme(
      color: color == null ? this.color : color(),
      size: size == null ? this.size : size(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SpinnerTheme && other.color == color && other.size == size;
  }

  @override
  int get hashCode => Object.hash(color, size);
}
