/// Global token override entrypoint for the error_system component.
class ErrorSystemThemeTokensConfigGlobalDefaults {
  final Object? iconColor;
  final Object? iconSize;
  final Object? titleStyle;
  final Object? messageStyle;
  final Object? cardPadding;
  final Object? cardBorderRadius;
  final Object? cardFillColor;
  final Object? bannerBackgroundColor;
  final Object? bannerBorderRadius;
  final Object? bannerPadding;
  final Object? bannerTitleStyle;
  final Object? bannerMessageStyle;
  final Object? bannerIcon;
  final Object? bannerBorderColor;
  final Object? snackbarBackgroundColor;
  final Object? snackbarTextStyle;
  final Object? snackbarBorderRadius;
  final Object? dialogSurfaceBlur;
  final Object? dialogSurfaceOpacity;
  final Object? dialogBarrierColor;
  final Object? dialogPadding;

  const ErrorSystemThemeTokensConfigGlobalDefaults({
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

  Map<String, Object?> toMap() => <String, Object?>{
    'iconColor': iconColor,
    'iconSize': iconSize,
    'titleStyle': titleStyle,
    'messageStyle': messageStyle,
    'cardPadding': cardPadding,
    'cardBorderRadius': cardBorderRadius,
    'cardFillColor': cardFillColor,
    'bannerBackgroundColor': bannerBackgroundColor,
    'bannerBorderRadius': bannerBorderRadius,
    'bannerPadding': bannerPadding,
    'bannerTitleStyle': bannerTitleStyle,
    'bannerMessageStyle': bannerMessageStyle,
    'bannerIcon': bannerIcon,
    'bannerBorderColor': bannerBorderColor,
    'snackbarBackgroundColor': snackbarBackgroundColor,
    'snackbarTextStyle': snackbarTextStyle,
    'snackbarBorderRadius': snackbarBorderRadius,
    'dialogSurfaceBlur': dialogSurfaceBlur,
    'dialogSurfaceOpacity': dialogSurfaceOpacity,
    'dialogBarrierColor': dialogBarrierColor,
    'dialogPadding': dialogPadding,
  };
}

class ErrorSystemThemeTokensConfigGlobalTokens {
  const ErrorSystemThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class ErrorSystemThemeTokensConfig {
  const ErrorSystemThemeTokensConfig._();

  /// Global component theme override for `ErrorSystemTheme`.
  static Object? global;
  static const String globalType = 'ErrorSystemTheme';
  static const ErrorSystemThemeTokensConfigGlobalDefaults globalDefaults =
      ErrorSystemThemeTokensConfigGlobalDefaults();
  static const ErrorSystemThemeTokensConfigGlobalTokens globalTokens =
      ErrorSystemThemeTokensConfigGlobalTokens();
}
