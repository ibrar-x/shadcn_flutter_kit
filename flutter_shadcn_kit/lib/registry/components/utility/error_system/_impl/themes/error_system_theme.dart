// ErrorSystemTheme: ComponentTheme overrides for error UI (icons, card, dialog, snackbar).
// Wrap a subtree with ComponentTheme<ErrorSystemTheme> to customize styling consistently.

import 'package:flutter/widgets.dart';

import '../../../../../shared/theme/theme.dart';
import '../core/app_error.dart';

class ErrorSystemTheme extends ComponentThemeData {
  const ErrorSystemTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.iconColor,
    this.iconSize,
    this.titleStyle,
    this.messageStyle,
    this.cardPadding,
    this.cardBorderRadius,
    this.cardFillColor,
    this.bannerBackgroundColor,
    this.bannerBorderRadius,
    this.bannerPadding,
    this.bannerTitleStyle,
    this.bannerMessageStyle,
    this.bannerIcon,
    this.bannerBorderColor,
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
  final Color? bannerBackgroundColor;
  final BorderRadiusGeometry? bannerBorderRadius;
  final EdgeInsetsGeometry? bannerPadding;
  final TextStyle? bannerTitleStyle;
  final TextStyle? bannerMessageStyle;
  final IconData? bannerIcon;
  final Color Function(ThemeData theme, AppError error)? bannerBorderColor;
  final Color? snackbarBackgroundColor;
  final TextStyle? snackbarTextStyle;
  final BorderRadiusGeometry? snackbarBorderRadius;
  final double? dialogSurfaceBlur;
  final double? dialogSurfaceOpacity;
  final Color? dialogBarrierColor;
  final EdgeInsetsGeometry? dialogPadding;
}
