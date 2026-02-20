// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class CollapsibleThemeDefaults {
  /// Widget fallback: theme.density.baseContentPadding * scaling
  final Object? padding;

  /// Widget fallback: Icons.unfold_less
  final Object? iconExpanded;

  /// Widget fallback: Icons.unfold_more
  final Object? iconCollapsed;

  /// Widget fallback: CrossAxisAlignment.stretch
  final Object? crossAxisAlignment;

  /// Widget fallback: MainAxisAlignment.start
  final Object? mainAxisAlignment;

  /// Widget fallback: 16 * scaling
  final Object? iconGap;

  const CollapsibleThemeDefaults({
    this.padding,
    this.iconExpanded,
    this.iconCollapsed,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.iconGap,
  });
}
