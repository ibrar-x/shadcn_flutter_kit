/// Global token override entrypoint for the popup component.
class PopupThemeTokensConfig {
  const PopupThemeTokensConfig._();

  /// Global component theme override for `MenuPopupTheme`.
  static Object? global;
  static const String globalType = 'MenuPopupTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'surfaceOpacity': null,
    'surfaceBlur': null,
    'padding': null,
    'fillColor': null,
    'borderColor': null,
    'borderRadius': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
