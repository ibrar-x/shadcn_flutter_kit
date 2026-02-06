part of '../../alert.dart';

/// Theme extensions used by [Alert].
class AlertTheme extends ComponentThemeData {
  const AlertTheme({
    this.padding,
    this.backgroundColor,
    this.borderColor,
  });

  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;

  AlertTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? borderColor,
  }) {
    return AlertTheme(
      padding: padding == null ? this.padding : padding(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AlertTheme &&
        other.padding == padding &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor;
  }

  @override
  int get hashCode => Object.hash(padding, backgroundColor, borderColor);
}
