// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class AccordionThemeDefaults {
  /// Widget fallback: kDefaultDuration
  final Object? duration;

  /// Widget fallback: Curves.easeIn
  final Object? curve;

  /// Widget fallback: Curves.easeOut
  final Object? reverseCurve;
  final Object? padding;
  final Object? iconGap;

  /// Widget fallback: 1 * scaling
  final Object? dividerHeight;

  /// Widget fallback: theme.colorScheme.muted
  final Object? dividerColor;

  /// Widget fallback: Icons.keyboard_arrow_up
  final Object? arrowIcon;

  /// Widget fallback: theme.colorScheme.mutedForeground
  final Object? arrowIconColor;

  const AccordionThemeDefaults({
    this.duration,
    this.curve,
    this.reverseCurve,
    this.padding,
    this.iconGap,
    this.dividerHeight,
    this.dividerColor,
    this.arrowIcon,
    this.arrowIconColor,
  });
}
