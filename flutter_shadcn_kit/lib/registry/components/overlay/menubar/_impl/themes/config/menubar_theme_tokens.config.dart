/// Global token override entrypoint for the menubar component.
class MenubarThemeTokensConfigGlobalDefaults {
  final Object? border;
  final Object? subMenuOffset;
  final Object? padding;
  final Object? borderColor;
  final Object? backgroundColor;
  final Object? borderRadius;

  const MenubarThemeTokensConfigGlobalDefaults({
    this.border,
    this.subMenuOffset,
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'border': border,
    'subMenuOffset': subMenuOffset,
    'padding': padding,
    'borderColor': borderColor,
    'backgroundColor': backgroundColor,
    'borderRadius': borderRadius,
  };
}

class MenubarThemeTokensConfigGlobalTokens {
  const MenubarThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class MenubarThemeTokensConfig {
  const MenubarThemeTokensConfig._();

  /// Global component theme override for `MenubarTheme`.
  static Object? global;
  static const String globalType = 'MenubarTheme';
  static const MenubarThemeTokensConfigGlobalDefaults globalDefaults =
      MenubarThemeTokensConfigGlobalDefaults();
  static const MenubarThemeTokensConfigGlobalTokens globalTokens =
      MenubarThemeTokensConfigGlobalTokens();
}
