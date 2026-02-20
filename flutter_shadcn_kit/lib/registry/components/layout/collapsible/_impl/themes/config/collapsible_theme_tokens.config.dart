/// Global token override entrypoint for the collapsible component.
class CollapsibleThemeTokensConfigGlobalDefaults {
  final Object? padding;
  final Object? iconExpanded;
  final Object? iconCollapsed;
  final Object? crossAxisAlignment;
  final Object? mainAxisAlignment;
  final Object? iconGap;

  const CollapsibleThemeTokensConfigGlobalDefaults({
    this.padding,
    this.iconExpanded,
    this.iconCollapsed,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.iconGap,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'padding': padding,
    'iconExpanded': iconExpanded,
    'iconCollapsed': iconCollapsed,
    'crossAxisAlignment': crossAxisAlignment,
    'mainAxisAlignment': mainAxisAlignment,
    'iconGap': iconGap,
  };
}

class CollapsibleThemeTokensConfigGlobalTokens {
  const CollapsibleThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class CollapsibleThemeTokensConfig {
  const CollapsibleThemeTokensConfig._();

  /// Global component theme override for `CollapsibleTheme`.
  static Object? global;
  static const String globalType = 'CollapsibleTheme';
  static const CollapsibleThemeTokensConfigGlobalDefaults globalDefaults =
      CollapsibleThemeTokensConfigGlobalDefaults();
  static const CollapsibleThemeTokensConfigGlobalTokens globalTokens =
      CollapsibleThemeTokensConfigGlobalTokens();
}
