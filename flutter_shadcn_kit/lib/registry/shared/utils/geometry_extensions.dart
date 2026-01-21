import 'package:flutter/widgets.dart';

extension AlignmentGeometryExtension on AlignmentGeometry {
  Alignment optionallyResolve(BuildContext context) {
    if (this is Alignment) {
      return this as Alignment;
    }
    return resolve(Directionality.of(context));
  }
}

extension BorderRadiusGeometryExtension on BorderRadiusGeometry {
  BorderRadius optionallyResolve(BuildContext context) {
    if (this is BorderRadius) {
      return this as BorderRadius;
    }
    return resolve(Directionality.of(context));
  }
}

extension EdgeInsetsGeometryExtension on EdgeInsetsGeometry {
  EdgeInsets optionallyResolve(BuildContext context) {
    if (this is EdgeInsets) {
      return this as EdgeInsets;
    }
    return resolve(Directionality.of(context));
  }
}
