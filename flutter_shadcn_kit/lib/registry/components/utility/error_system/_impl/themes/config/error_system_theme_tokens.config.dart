/// Global token override entrypoint for the error_system component.
class ErrorSystemThemeTokensConfig {
  const ErrorSystemThemeTokensConfig._();

  /// Global component theme override for `ErrorSystemTheme`.
  static Object? global;
  static const String globalType = 'ErrorSystemTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'iconColor': null,
    'iconSize': null,
    'titleStyle': null,
    'messageStyle': null,
    'cardPadding': null,
    'cardBorderRadius': null,
    'cardFillColor': null,
    'bannerBackgroundColor': null,
    'bannerBorderRadius': null,
    'bannerPadding': null,
    'bannerTitleStyle': null,
    'bannerMessageStyle': null,
    'bannerIcon': null,
    'bannerBorderColor': null,
    'snackbarBackgroundColor': null,
    'snackbarTextStyle': null,
    'snackbarBorderRadius': null,
    'dialogSurfaceBlur': null,
    'dialogSurfaceOpacity': null,
    'dialogBarrierColor': null,
    'dialogPadding': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
