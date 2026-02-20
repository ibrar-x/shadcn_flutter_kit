/// Global token override entrypoint for the dropdown_menu component.
class DropdownMenuThemeTokensConfigGlobalDefaults {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;

  const DropdownMenuThemeTokensConfigGlobalDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'surfaceOpacity': surfaceOpacity,
    'surfaceBlur': surfaceBlur,
  };
}

class DropdownMenuThemeTokensConfigGlobalTokens {
  const DropdownMenuThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class DropdownMenuThemeTokensConfig {
  const DropdownMenuThemeTokensConfig._();

  /// Global component theme override for `DropdownMenuTheme`.
  static Object? global;
  static const String globalType = 'DropdownMenuTheme';
  static const DropdownMenuThemeTokensConfigGlobalDefaults globalDefaults =
      DropdownMenuThemeTokensConfigGlobalDefaults();
  static const DropdownMenuThemeTokensConfigGlobalTokens globalTokens =
      DropdownMenuThemeTokensConfigGlobalTokens();
}
