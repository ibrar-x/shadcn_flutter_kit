/// Global token override entrypoint for the context_menu component.
class ContextMenuThemeTokensConfig {
  const ContextMenuThemeTokensConfig._();

  /// Global component theme override for `ContextMenuTheme`.
  static Object? global;
  static const String globalType = 'ContextMenuTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'surfaceOpacity': null,
    'surfaceBlur': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
