// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class EmptyStateThemeDefaults {
  /// Widget fallback: theme.colorScheme.mutedForeground
  final Object? iconColor;
  final Object? iconSize;
  final Object? titleStyle;
  final Object? descriptionStyle;
  final Object? padding;

  /// Widget fallback: maxWidth ?? 520 * scaling
  final Object? maxWidth;
  final Object? cardBorderRadius;
  final Object? cardFillColor;

  /// Widget fallback: theme.colorScheme.muted
  final Object? iconContainerColor;
  final Object? iconContainerBorderColor;
  final Object? iconContainerBorderRadius;
  final Object? iconContainerPadding;

  const EmptyStateThemeDefaults({
    this.iconColor,
    this.iconSize,
    this.titleStyle,
    this.descriptionStyle,
    this.padding,
    this.maxWidth,
    this.cardBorderRadius,
    this.cardFillColor,
    this.iconContainerColor,
    this.iconContainerBorderColor,
    this.iconContainerBorderRadius,
    this.iconContainerPadding,
  });
}
