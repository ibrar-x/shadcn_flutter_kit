/// Global token override entrypoint for the drawer component.
class DrawerThemeTokensConfigGlobalDefaults {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? barrierColor;
  final Object? showDragHandle;
  final Object? dragHandleSize;

  const DrawerThemeTokensConfigGlobalDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.showDragHandle,
    this.dragHandleSize,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'surfaceOpacity': surfaceOpacity,
    'surfaceBlur': surfaceBlur,
    'barrierColor': barrierColor,
    'showDragHandle': showDragHandle,
    'dragHandleSize': dragHandleSize,
  };
}

class DrawerThemeTokensConfigGlobalTokens {
  const DrawerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class DrawerThemeTokensConfig {
  const DrawerThemeTokensConfig._();

  /// Global component theme override for `DrawerTheme`.
  static Object? global;
  static const String globalType = 'DrawerTheme';
  static const DrawerThemeTokensConfigGlobalDefaults globalDefaults =
      DrawerThemeTokensConfigGlobalDefaults();
  static const DrawerThemeTokensConfigGlobalTokens globalTokens =
      DrawerThemeTokensConfigGlobalTokens();
}
