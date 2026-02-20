/// Global token override entrypoint for the swiper component.
class SwiperThemeTokensConfig {
  const SwiperThemeTokensConfig._();

  /// Global component theme override for `SwiperTheme`.
  static Object? global;
  static const String globalType = 'SwiperTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'expands': null,
    'draggable': null,
    'barrierDismissible': null,
    'backdropBuilder': null,
    'useSafeArea': null,
    'showDragHandle': null,
    'borderRadius': null,
    'dragHandleSize': null,
    'transformBackdrop': null,
    'surfaceOpacity': null,
    'surfaceBlur': null,
    'barrierColor': null,
    'behavior': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
