import 'package:flutter/widgets.dart';

import '../../../../../shared/theme/theme.dart';

/// Theme overrides for the EmptyState widget.
class EmptyStateTheme extends ComponentThemeData {
  const EmptyStateTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.iconColor,
    this.iconSize,
    this.titleStyle,
    this.descriptionStyle,
    this.padding,
    this.maxWidth,
    this.cardBorderRadius,
    this.cardFillColor,
    this.iconContainerColor,
    this.iconContainerBorderColor,
    this.iconContainerBorderRadius,
    this.iconContainerPadding,
  });

  final Color? iconColor;
  final double? iconSize;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;
  final BorderRadiusGeometry? cardBorderRadius;
  final Color? cardFillColor;
  final Color? iconContainerColor;
  final Color? iconContainerBorderColor;
  final BorderRadiusGeometry? iconContainerBorderRadius;
  final EdgeInsetsGeometry? iconContainerPadding;
}
