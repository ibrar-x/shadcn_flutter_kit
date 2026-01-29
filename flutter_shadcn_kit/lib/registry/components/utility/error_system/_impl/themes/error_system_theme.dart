import 'package:flutter/widgets.dart';

import '../../../../../shared/theme/theme.dart';

class ErrorSystemTheme extends ComponentThemeData {
  const ErrorSystemTheme({
    this.iconColor,
    this.iconSize,
    this.titleStyle,
    this.messageStyle,
    this.cardPadding,
    this.cardBorderRadius,
    this.cardFillColor,
    this.snackbarBackgroundColor,
    this.snackbarTextStyle,
    this.snackbarBorderRadius,
    this.dialogSurfaceBlur,
    this.dialogSurfaceOpacity,
    this.dialogBarrierColor,
    this.dialogPadding,
  });

  final Color? iconColor;
  final double? iconSize;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry? cardPadding;
  final BorderRadiusGeometry? cardBorderRadius;
  final Color? cardFillColor;
  final Color? snackbarBackgroundColor;
  final TextStyle? snackbarTextStyle;
  final BorderRadiusGeometry? snackbarBorderRadius;
  final double? dialogSurfaceBlur;
  final double? dialogSurfaceOpacity;
  final Color? dialogBarrierColor;
  final EdgeInsetsGeometry? dialogPadding;
}
