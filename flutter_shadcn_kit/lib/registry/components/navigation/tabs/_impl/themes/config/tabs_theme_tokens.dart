// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class TabsThemeTokens {
  final Object? containerPadding;
  final Object? tabPadding;
  final Object? backgroundColor;
  final Object? borderRadius;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const TabsThemeTokens({
    this.containerPadding,
    this.tabPadding,
    this.backgroundColor,
    this.borderRadius,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const tabsThemeTokens = TabsThemeTokens();

class TabContainerThemeTokens {
  final Object? builder;
  final Object? childBuilder;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const TabContainerThemeTokens({
    this.builder,
    this.childBuilder,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const tabContainerThemeTokens = TabContainerThemeTokens();

class TabListThemeTokens {
  final Object? borderColor;
  final Object? borderWidth;
  final Object? indicatorColor;
  final Object? indicatorHeight;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const TabListThemeTokens({
    this.borderColor,
    this.borderWidth,
    this.indicatorColor,
    this.indicatorHeight,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const tabListThemeTokens = TabListThemeTokens();

class TabPaneThemeTokens {
  final Object? borderRadius;
  final Object? backgroundColor;
  final Object? border;
  final Object? barHeight;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const TabPaneThemeTokens({
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.barHeight,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const tabPaneThemeTokens = TabPaneThemeTokens();
