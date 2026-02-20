/// Global token override entrypoint for the dialog component.
class DialogThemeTokensConfig {
  const DialogThemeTokensConfig._();

  /// Global component theme override for `ModalBackdropTheme`.
  static Object? global;
  static const String globalType = 'ModalBackdropTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'borderRadius': null,
    'padding': null,
    'barrierColor': null,
    'modal': null,
    'surfaceClip': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
