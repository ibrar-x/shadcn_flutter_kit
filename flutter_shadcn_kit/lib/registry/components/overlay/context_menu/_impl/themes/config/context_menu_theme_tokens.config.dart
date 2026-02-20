/// Global token override entrypoint for the context_menu component.
class ContextMenuThemeTokensConfigGlobalDefaults {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;

  const ContextMenuThemeTokensConfigGlobalDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'surfaceOpacity': surfaceOpacity,
    'surfaceBlur': surfaceBlur,
  };
}

class ContextMenuThemeTokensConfigGlobalTokens {
  const ContextMenuThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class ContextMenuThemeTokensConfig {
  const ContextMenuThemeTokensConfig._();

  /// Global component theme override for `ContextMenuTheme`.
  static Object? global;
  static const String globalType = 'ContextMenuTheme';
  static const ContextMenuThemeTokensConfigGlobalDefaults globalDefaults =
      ContextMenuThemeTokensConfigGlobalDefaults();
  static const ContextMenuThemeTokensConfigGlobalTokens globalTokens =
      ContextMenuThemeTokensConfigGlobalTokens();
}
