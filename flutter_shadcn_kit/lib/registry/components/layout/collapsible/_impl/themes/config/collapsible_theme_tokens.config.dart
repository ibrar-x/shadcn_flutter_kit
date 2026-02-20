/// Global token override entrypoint for the collapsible component.
class CollapsibleThemeTokensConfig {
  const CollapsibleThemeTokensConfig._();

  /// Global component theme override for `CollapsibleTheme`.
  static Object? global;
  static const String globalType = 'CollapsibleTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'padding': null,
    'iconExpanded': null,
    'iconCollapsed': null,
    'crossAxisAlignment': null,
    'mainAxisAlignment': null,
    'iconGap': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}
