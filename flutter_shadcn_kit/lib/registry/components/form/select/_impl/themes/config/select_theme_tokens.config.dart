/// Global token override entrypoint for the select component.
class SelectThemeTokensConfig {
  const SelectThemeTokensConfig._();

  /// Global component theme override for `SelectTheme`.
  static Object? global;
  static const String globalType = 'SelectTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'popupConstraints': null,
    'popoverAlignment': 'Alignment.topCenter',
    'popoverAnchorAlignment': null,
    'borderRadius': null,
    'padding': null,
    'disableHoverEffect': false,
    'canUnselect': false,
    'autoClosePopover': true,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
