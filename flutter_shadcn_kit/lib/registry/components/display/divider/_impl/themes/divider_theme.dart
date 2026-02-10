part of '../../divider.dart';

/// Theme data for divider widgets.
class DividerTheme extends ComponentThemeData {
  final Color? color;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final EdgeInsetsGeometry? padding;
  final AxisAlignmentGeometry? childAlignment;

  const DividerTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.padding,
    this.childAlignment,
  });

  DividerTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<double?>? height,
    ValueGetter<double?>? thickness,
    ValueGetter<double?>? indent,
    ValueGetter<double?>? endIndent,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<AxisAlignmentGeometry?>? childAlignment,
  }) {
    return DividerTheme(
      color: color == null ? this.color : color(),
      height: height == null ? this.height : height(),
      thickness: thickness == null ? this.thickness : thickness(),
      indent: indent == null ? this.indent : indent(),
      endIndent: endIndent == null ? this.endIndent : endIndent(),
      padding: padding == null ? this.padding : padding(),
      childAlignment: childAlignment == null
          ? this.childAlignment
          : childAlignment(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DividerTheme &&
        other.color == color &&
        other.height == height &&
        other.thickness == thickness &&
        other.indent == indent &&
        other.endIndent == endIndent &&
        other.padding == padding &&
        other.childAlignment == childAlignment;
  }

  @override
  int get hashCode => Object.hash(
    color,
    height,
    thickness,
    indent,
    endIndent,
    padding,
    childAlignment,
  );
}
