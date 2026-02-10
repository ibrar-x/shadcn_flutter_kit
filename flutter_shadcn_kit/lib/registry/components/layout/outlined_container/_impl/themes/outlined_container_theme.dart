part of '../../outlined_container.dart';

/// Theme data for [OutlinedContainer].
class OutlinedContainerTheme extends ComponentThemeData {
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final BorderStyle? borderStyle;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const OutlinedContainerTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderStyle,
    this.borderWidth,
    this.boxShadow,
    this.padding,
    this.surfaceOpacity,
    this.surfaceBlur,
  });

  OutlinedContainerTheme copyWith({
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? borderColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<BorderStyle?>? borderStyle,
    ValueGetter<double?>? borderWidth,
    ValueGetter<List<BoxShadow>?>? boxShadow,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
  }) {
    return OutlinedContainerTheme(
      backgroundColor: backgroundColor == null
          ? this.backgroundColor
          : backgroundColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      borderStyle: borderStyle == null ? this.borderStyle : borderStyle(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      boxShadow: boxShadow == null ? this.boxShadow : boxShadow(),
      padding: padding == null ? this.padding : padding(),
      surfaceOpacity: surfaceOpacity == null
          ? this.surfaceOpacity
          : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is OutlinedContainerTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderRadius == borderRadius &&
        other.borderStyle == borderStyle &&
        other.borderWidth == borderWidth &&
        other.boxShadow == boxShadow &&
        other.padding == padding &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur;
  }

  @override
  int get hashCode => Object.hash(
    backgroundColor,
    borderColor,
    borderRadius,
    borderStyle,
    borderWidth,
    boxShadow,
    padding,
    surfaceOpacity,
    surfaceBlur,
  );
}
