// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class ErrorSystemThemeDefaults {
  /// Widget fallback: theme.colorScheme.destructive
  final Object? iconColor;

  /// Widget fallback: 36 * scaling
  final Object? iconSize;
  final Object? titleStyle;
  final Object? messageStyle;
  final Object? cardPadding;
  final Object? cardBorderRadius;
  final Object? cardFillColor;

  /// Widget fallback: theme.colorScheme.card
  final Object? bannerBackgroundColor;

  /// Widget fallback: theme.borderRadiusLg
  final Object? bannerBorderRadius;
  final Object? bannerPadding;
  final Object? bannerTitleStyle;
  final Object? bannerMessageStyle;

  /// Widget fallback: RadixIcons.exclamationTriangle
  final Object? bannerIcon;
  final Object? bannerBorderColor;
  final Object? snackbarBackgroundColor;
  final Object? snackbarTextStyle;
  final Object? snackbarBorderRadius;
  final Object? dialogSurfaceBlur;
  final Object? dialogSurfaceOpacity;
  final Object? dialogBarrierColor;
  final Object? dialogPadding;

  const ErrorSystemThemeDefaults({
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
}
