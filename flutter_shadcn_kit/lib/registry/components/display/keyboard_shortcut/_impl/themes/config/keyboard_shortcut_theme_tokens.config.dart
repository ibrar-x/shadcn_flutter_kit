/// Global token override entrypoint for the keyboard_shortcut component.
class KeyboardShortcutThemeTokensConfigGlobalDefaults {
  final Object? spacing;
  final Object? keyPadding;
  final Object? keyShadow;

  const KeyboardShortcutThemeTokensConfigGlobalDefaults({
    this.spacing,
    this.keyPadding,
    this.keyShadow,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'spacing': spacing,
    'keyPadding': keyPadding,
    'keyShadow': keyShadow,
  };
}

class KeyboardShortcutThemeTokensConfigGlobalTokens {
  const KeyboardShortcutThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class KeyboardShortcutThemeTokensConfig {
  const KeyboardShortcutThemeTokensConfig._();

  /// Global component theme override for `KeyboardShortcutTheme`.
  static Object? global;
  static const String globalType = 'KeyboardShortcutTheme';
  static const KeyboardShortcutThemeTokensConfigGlobalDefaults globalDefaults =
      KeyboardShortcutThemeTokensConfigGlobalDefaults();
  static const KeyboardShortcutThemeTokensConfigGlobalTokens globalTokens =
      KeyboardShortcutThemeTokensConfigGlobalTokens();
}
