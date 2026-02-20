/// Global token override entrypoint for the keyboard_shortcut component.
class KeyboardShortcutThemeTokensConfig {
  const KeyboardShortcutThemeTokensConfig._();

  /// Global component theme override for `KeyboardShortcutTheme`.
  static Object? global;
  static const String globalType = 'KeyboardShortcutTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'spacing': null,
    'keyPadding': null,
    'keyShadow': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
