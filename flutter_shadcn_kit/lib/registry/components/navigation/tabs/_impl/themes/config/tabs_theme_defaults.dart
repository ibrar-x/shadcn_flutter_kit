// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class TabsThemeDefaults {
  final Object? containerPadding;
  final Object? tabPadding;
  final Object? backgroundColor;

  /// Widget fallback: compTheme?.borderRadius ?? theme.borderRadiusLg
  final Object? borderRadius;

  const TabsThemeDefaults({
    this.containerPadding,
    this.tabPadding,
    this.backgroundColor,
    this.borderRadius,
  });
}

class TabContainerThemeDefaults {
  final Object? builder;

  /// Widget fallback: compTheme?.childBuilder ?? ((_
  final Object? childBuilder;

  const TabContainerThemeDefaults({this.builder, this.childBuilder});
}

class TabListThemeDefaults {
  final Object? borderColor;
  final Object? borderWidth;
  final Object? indicatorColor;
  final Object? indicatorHeight;

  const TabListThemeDefaults({
    this.borderColor,
    this.borderWidth,
    this.indicatorColor,
    this.indicatorHeight,
  });
}

class TabPaneThemeDefaults {
  /// Widget fallback: compTheme?.borderRadius ?? theme.borderRadiusLg
  final Object? borderRadius;
  final Object? backgroundColor;

  /// Widget fallback: compTheme?.border
  final Object? border;

  /// Widget fallback: compTheme?.barHeight ?? (32 * theme.scaling
  final Object? barHeight;

  const TabPaneThemeDefaults({
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.barHeight,
  });
}
