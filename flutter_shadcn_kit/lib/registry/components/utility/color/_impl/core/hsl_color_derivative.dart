part of '../../color.dart';

final class _HSLColor extends ColorDerivative {
  final HSLColor color;
  const _HSLColor(this.color);
  @override
  String toString() => color.toString();

  @override
  Color toColor() {
    return color.toColor();
  }

  @override
  HSVColor toHSVColor() {
    return HSVColor.fromColor(color.toColor());
  }

  @override
  HSLColor toHSLColor() {
    return color;
  }

  @override
  double get opacity => color.alpha;

  @override
  ColorDerivative changeToOpacity(double alpha) {
    return _HSLColor(color.withAlpha(alpha));
  }

  @override
  ColorDerivative changeToHSLHue(double hue) {
    return _HSLColor(color.withHue(hue));
  }

  @override
  ColorDerivative changeToHSLSaturation(double saturation) {
    return _HSLColor(color.withSaturation(saturation));
  }

  @override
  ColorDerivative changeToHSLLightness(double lightness) {
    return _HSLColor(color.withLightness(lightness));
  }

  @override
  ColorDerivative changeToHSVHue(double hue) {
    // should be the same as changing HSL hue
    return _HSLColor(color.withHue(hue));
  }

  @override
  ColorDerivative transform(ColorDerivative old) {
    if (old is _HSVColor) {
      return _HSVColor(HSVColor.fromColor(color.toColor()));
    } else if (old is _HSLColor) {
      return _HSLColor(color);
    } else {
      throw FlutterError('Invalid color type');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is _HSVColor) {
      return color == other.toHSLColor();
    }

    return other is _HSLColor && other.color == color;
  }

  @override
  int get hashCode => color.hashCode;

  @override
  double get hslHue => color.hue;

  @override
  double get hslSat => color.saturation;

  @override
  double get hslVal => color.lightness;

  @override
  double get hsvHue => HSVColor.fromColor(color.toColor()).hue;

  @override
  double get hsvSat => HSVColor.fromColor(color.toColor()).saturation;

  @override
  double get hsvVal => HSVColor.fromColor(color.toColor()).value;

  @override
  int get red => (color.toColor().r * 255).toInt() & 0xFF;

  @override
  int get green => (color.toColor().g * 255).toInt() & 0xFF;

  @override
  int get blue => (color.toColor().b * 255).toInt() & 0xFF;
}
