// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class NavigationBarThemeDefaults {
  final Object? backgroundColor;
  final Object? alignment;
  final Object? direction;
  final Object? spacing;
  final Object? labelType;
  final Object? labelPosition;
  final Object? labelSize;
  final Object? padding;

  const NavigationBarThemeDefaults({
    this.backgroundColor,
    this.alignment = 'NavigationBarAlignment.center',
    this.direction = 'Axis.horizontal',
    this.spacing = '8 * scaling',
    this.labelType = 'NavigationLabelType.none',
    this.labelPosition = 'NavigationLabelPosition.bottom',
    this.labelSize = 'NavigationLabelSize.small',
    this.padding = 'EdgeInsets.symmetric( vertical: theme.density.baseGap * scaling, horizontal: theme.density.baseContentPadding * scaling * 0.75, )',
  });
}
