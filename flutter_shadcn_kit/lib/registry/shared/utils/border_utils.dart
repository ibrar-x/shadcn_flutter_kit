import 'dart:math';

import 'package:flutter/widgets.dart';

/// Subtracts a border width from a border radius.
///
/// Reduces each corner's radius by the border width, ensuring the inner
/// radius accounts for the border thickness. Prevents negative radii.
BorderRadius subtractByBorder(BorderRadius radius, double borderWidth) {
  return BorderRadius.only(
    topLeft: _subtractSafe(radius.topLeft, Radius.circular(borderWidth)),
    topRight: _subtractSafe(radius.topRight, Radius.circular(borderWidth)),
    bottomLeft: _subtractSafe(radius.bottomLeft, Radius.circular(borderWidth)),
    bottomRight:
        _subtractSafe(radius.bottomRight, Radius.circular(borderWidth)),
  );
}

Radius _subtractSafe(Radius a, Radius b) {
  return Radius.elliptical(
    max(0, a.x - b.x),
    max(0, a.y - b.y),
  );
}

/// Resolves a BorderRadiusGeometry to BorderRadius if needed.
BorderRadius? optionallyResolveBorderRadius(
  BuildContext context,
  BorderRadiusGeometry? radius,
) {
  if (radius == null) {
    return null;
  }
  if (radius is BorderRadius) {
    return radius;
  }
  return radius.resolve(Directionality.of(context));
}
