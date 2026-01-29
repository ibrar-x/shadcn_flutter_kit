import 'package:flutter/widgets.dart';

import '../../../../../shared/theme/theme.dart';

/// Theme overrides for the EmptyState widget.
class EmptyStateTheme extends ComponentThemeData {
  const EmptyStateTheme({
    this.iconColor,
    this.iconSize,
    this.titleStyle,
    this.descriptionStyle,
    this.padding,
    this.maxWidth,
    this.cardBorderRadius,
    this.cardFillColor,
  });

  final Color? iconColor;
  final double? iconSize;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;
  final BorderRadiusGeometry? cardBorderRadius;
  final Color? cardFillColor;
}
