/// Global token override entrypoint for the dialog component.
class DialogThemeTokensConfigGlobalDefaults {
  final Object? borderRadius;
  final Object? padding;
  final Object? barrierColor;
  final Object? modal;
  final Object? surfaceClip;

  const DialogThemeTokensConfigGlobalDefaults({
    this.borderRadius,
    this.padding,
    this.barrierColor,
    this.modal,
    this.surfaceClip,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'borderRadius': borderRadius,
    'padding': padding,
    'barrierColor': barrierColor,
    'modal': modal,
    'surfaceClip': surfaceClip,
  };
}

class DialogThemeTokensConfigGlobalTokens {
  const DialogThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class DialogThemeTokensConfig {
  const DialogThemeTokensConfig._();

  /// Global component theme override for `ModalBackdropTheme`.
  static Object? global;
  static const String globalType = 'ModalBackdropTheme';
  static const DialogThemeTokensConfigGlobalDefaults globalDefaults =
      DialogThemeTokensConfigGlobalDefaults();
  static const DialogThemeTokensConfigGlobalTokens globalTokens =
      DialogThemeTokensConfigGlobalTokens();
}
