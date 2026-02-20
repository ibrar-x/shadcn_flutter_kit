/// Global token override entrypoint for the menu component.
class MenuThemeTokensConfig {
  const MenuThemeTokensConfig._();

  /// Global component theme override.
  static Object? global;
  static const String globalType = 'MenuTheme';

  /// Global component theme override for `MenuPopupTheme`.
  static Object? menuPopupTheme;
  static const String menuPopupThemeType = 'MenuPopupTheme';

  /// Global component theme override for `MenubarTheme`.
  static Object? menubarTheme;
  static const String menubarThemeType = 'MenubarTheme';
}
