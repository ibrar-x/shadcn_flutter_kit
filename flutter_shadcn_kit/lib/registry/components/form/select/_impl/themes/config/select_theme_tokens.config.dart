/// Global token override entrypoint for the select component.
class SelectThemeTokensConfig {
  const SelectThemeTokensConfig._();

  /// Global component theme override for `SelectTheme`.
  static Object? global;
  static const String globalType = 'SelectTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'popupConstraints': null,
    'popoverAlignment': null,
    'popoverAnchorAlignment': null,
    'borderRadius': null,
    'padding': null,
    'disableHoverEffect': null,
    'canUnselect': null,
    'autoClosePopover': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
