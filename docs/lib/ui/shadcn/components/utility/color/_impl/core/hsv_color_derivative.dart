part of '../../color.dart';

final class _HSVColor extends ColorDerivative {
  final HSVColor color;
  const _HSVColor(this.color);

  @override
  String toString() => color.toString();

  @override
  Color toColor() {
    return color.toColor();
  }

  @override
  HSVColor toHSVColor() {
    return color;
  }

  @override
  HSLColor toHSLColor() {
    return HSLColor.fromColor(color.toColor());
  }

  @override
  double get opacity => color.alpha;

  @override
  ColorDerivative changeToOpacity(double alpha) {
    return _HSVColor(color.withAlpha(alpha));
  }

  @override
  ColorDerivative changeToHSVHue(double hue) {
    return _HSVColor(color.withHue(hue));
  }

  @override
  ColorDerivative changeToHSVSaturation(double saturation) {
    return _HSVColor(color.withSaturation(saturation));
  }

  @override
  ColorDerivative changeToHSVValue(double value) {
    return _HSVColor(color.withValue(value));
  }

  @override
  ColorDerivative transform(ColorDerivative old) {
    if (old is _HSVColor) {
      return _HSVColor(color);
    } else if (old is _HSLColor) {
      return _HSLColor(HSLColor.fromColor(color.toColor()));
    } else {
      throw FlutterError('Invalid color type');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is _HSLColor) {
      return color == other.toHSVColor();
    }

    return other is _HSVColor && other.color == color;
  }

  @override
  int get hashCode => color.hashCode;

  @override
  double get hslHue => HSLColor.fromColor(color.toColor()).hue;

  @override
  double get hslSat => HSLColor.fromColor(color.toColor()).saturation;

  @override
  double get hslVal => HSLColor.fromColor(color.toColor()).lightness;

  @override
  double get hsvHue => color.hue;

  @override
  double get hsvSat => color.saturation;

  @override
  double get hsvVal => color.value;

  @override
  int get red => (color.toColor().r * 255).round() & 0xFF;

  @override
  int get green => (color.toColor().g * 255).round() & 0xFF;

  @override
  int get blue => (color.toColor().b * 255).round() & 0xFF;
}
