import 'dart:ui';
import 'package:flutter/painting.dart' show HSLColor;

String colorToHex(Color color,
    [bool showAlpha = false, bool hashPrefix = true]) {
  String r = ((color.r * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
  String g = ((color.g * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
  String b = ((color.b * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
  if (showAlpha) {
    String a =
        ((color.a * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
    return hashPrefix ? '#$a$r$g$b' : '$a$r$g$b';
  } else {
    return hashPrefix ? '#$r$g$b' : '$r$g$b';
  }
}

/// Extension adding color manipulation utilities to [Color].
extension ColorExtension on Color {
  /// Scales the alpha channel by a factor.
  ///
  /// Parameters:
  /// - [factor] (`double`, required): Multiplier for alpha (0.0 to 1.0+).
  ///
  /// Returns: `Color` — color with scaled alpha.
  Color scaleAlpha(double factor) {
    return withValues(
      alpha: a * factor,
    );
  }

  /// Returns a color with the given luminance (0.0 - 1.0).
  Color withLuminance(double luminance) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness(luminance.clamp(0.0, 1.0)).toColor();
  }
}
