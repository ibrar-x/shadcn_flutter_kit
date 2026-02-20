/// Global token override entrypoint for the drawer component.
class DrawerThemeTokensConfig {
  const DrawerThemeTokensConfig._();

  /// Global component theme override for `DrawerTheme`.
  static Object? global;
  static const String globalType = 'DrawerTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'surfaceOpacity': null,
    'surfaceBlur': null,
    'barrierColor': null,
    'showDragHandle': null,
    'dragHandleSize': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
