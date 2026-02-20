// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class TabsThemeDefaults {
  final Object? containerPadding;
  final Object? tabPadding;
  final Object? backgroundColor;
  final Object? borderRadius;

  const TabsThemeDefaults({
    this.containerPadding,
    this.tabPadding,
    this.backgroundColor = 'theme.colorScheme.card',
    this.borderRadius = 'theme.borderRadiusLg',
  });
}

class TabContainerThemeDefaults {
  final Object? builder;
  final Object? childBuilder;

  const TabContainerThemeDefaults({
    this.builder,
    this.childBuilder,
  });
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
  final Object? borderRadius;
  final Object? backgroundColor;
  final Object? border;
  final Object? barHeight;

  const TabPaneThemeDefaults({
    this.borderRadius = 'theme.borderRadiusLg',
    this.backgroundColor = 'theme.colorScheme.card',
    this.border,
    this.barHeight = '(32 * theme.scaling)',
  });
}
