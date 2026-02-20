/// Global token override entrypoint for the swiper component.
class SwiperThemeTokensConfigGlobalDefaults {
  final Object? expands;
  final Object? draggable;
  final Object? barrierDismissible;
  final Object? backdropBuilder;
  final Object? useSafeArea;
  final Object? showDragHandle;
  final Object? borderRadius;
  final Object? dragHandleSize;
  final Object? transformBackdrop;
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? barrierColor;
  final Object? behavior;

  const SwiperThemeTokensConfigGlobalDefaults({
    this.expands,
    this.draggable,
    this.barrierDismissible,
    this.backdropBuilder,
    this.useSafeArea,
    this.showDragHandle,
    this.borderRadius,
    this.dragHandleSize,
    this.transformBackdrop,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.behavior = 'HitTestBehavior.translucent',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'expands': expands,
    'draggable': draggable,
    'barrierDismissible': barrierDismissible,
    'backdropBuilder': backdropBuilder,
    'useSafeArea': useSafeArea,
    'showDragHandle': showDragHandle,
    'borderRadius': borderRadius,
    'dragHandleSize': dragHandleSize,
    'transformBackdrop': transformBackdrop,
    'surfaceOpacity': surfaceOpacity,
    'surfaceBlur': surfaceBlur,
    'barrierColor': barrierColor,
    'behavior': behavior,
  };
}

class SwiperThemeTokensConfigGlobalTokens {
  const SwiperThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class SwiperThemeTokensConfig {
  const SwiperThemeTokensConfig._();

  /// Global component theme override for `SwiperTheme`.
  static Object? global;
  static const String globalType = 'SwiperTheme';
  static const SwiperThemeTokensConfigGlobalDefaults globalDefaults =
      SwiperThemeTokensConfigGlobalDefaults();
  static const SwiperThemeTokensConfigGlobalTokens globalTokens =
      SwiperThemeTokensConfigGlobalTokens();
}
