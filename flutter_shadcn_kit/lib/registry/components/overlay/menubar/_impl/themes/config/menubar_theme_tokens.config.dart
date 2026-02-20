/// Global token override entrypoint for the menubar component.
class MenubarThemeTokensConfig {
  const MenubarThemeTokensConfig._();

  /// Global component theme override for `MenubarTheme`.
  static Object? global;
  static const String globalType = 'MenubarTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'border': null,
    'subMenuOffset': null,
    'padding': null,
    'borderColor': null,
    'backgroundColor': null,
    'borderRadius': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
