/// Global token override entrypoint for the menu component.
class MenuThemeTokensConfigGlobalDefaults {
  final Object? itemPadding;
  final Object? subMenuOffset;

  const MenuThemeTokensConfigGlobalDefaults({
    this.itemPadding = 'EdgeInsets.zero',
    this.subMenuOffset,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'itemPadding': itemPadding,
    'subMenuOffset': subMenuOffset,
  };
}

class MenuThemeTokensConfigGlobalTokens {
  const MenuThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class MenuThemeTokensConfigMenuPopupThemeDefaults {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? padding;
  final Object? fillColor;
  final Object? borderColor;
  final Object? borderRadius;

  const MenuThemeTokensConfigMenuPopupThemeDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'surfaceOpacity': surfaceOpacity,
    'surfaceBlur': surfaceBlur,
    'padding': padding,
    'fillColor': fillColor,
    'borderColor': borderColor,
    'borderRadius': borderRadius,
  };
}

class MenuThemeTokensConfigMenuPopupThemeTokens {
  const MenuThemeTokensConfigMenuPopupThemeTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class MenuThemeTokensConfigMenubarThemeDefaults {
  final Object? border;
  final Object? subMenuOffset;
  final Object? padding;
  final Object? borderColor;
  final Object? backgroundColor;
  final Object? borderRadius;

  const MenuThemeTokensConfigMenubarThemeDefaults({
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

class MenuThemeTokensConfigMenubarThemeTokens {
  const MenuThemeTokensConfigMenubarThemeTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class MenuThemeTokensConfig {
  const MenuThemeTokensConfig._();

  /// Global component theme override for `MenuTheme`.
  static Object? global;
  static const String globalType = 'MenuTheme';
  static const MenuThemeTokensConfigGlobalDefaults globalDefaults =
      MenuThemeTokensConfigGlobalDefaults();
  static const MenuThemeTokensConfigGlobalTokens globalTokens =
      MenuThemeTokensConfigGlobalTokens();

  /// Global component theme override for `MenuPopupTheme`.
  static Object? menuPopupTheme;
  static const String menuPopupThemeType = 'MenuPopupTheme';
  static const MenuThemeTokensConfigMenuPopupThemeDefaults
  menuPopupThemeDefaults = MenuThemeTokensConfigMenuPopupThemeDefaults();
  static const MenuThemeTokensConfigMenuPopupThemeTokens menuPopupThemeTokens =
      MenuThemeTokensConfigMenuPopupThemeTokens();

  /// Global component theme override for `MenubarTheme`.
  static Object? menubarTheme;
  static const String menubarThemeType = 'MenubarTheme';
  static const MenuThemeTokensConfigMenubarThemeDefaults menubarThemeDefaults =
      MenuThemeTokensConfigMenubarThemeDefaults();
  static const MenuThemeTokensConfigMenubarThemeTokens menubarThemeTokens =
      MenuThemeTokensConfigMenubarThemeTokens();
}
