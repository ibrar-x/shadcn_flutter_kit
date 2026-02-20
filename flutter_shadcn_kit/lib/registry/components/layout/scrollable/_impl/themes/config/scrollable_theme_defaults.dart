// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class ScrollableClientThemeDefaults {
  final Object? diagonalDragBehavior;
  final Object? dragStartBehavior;
  final Object? keyboardDismissBehavior;

  /// Widget fallback: compTheme?.clipBehavior ?? Clip.hardEdge
  final Object? clipBehavior;

  /// Widget fallback: compTheme?.hitTestBehavior ?? HitTestBehavior.opaque
  final Object? hitTestBehavior;

  /// Widget fallback: compTheme?.overscroll ?? false
  final Object? overscroll;

  const ScrollableClientThemeDefaults({
    this.diagonalDragBehavior,
    this.dragStartBehavior,
    this.keyboardDismissBehavior,
    this.clipBehavior,
    this.hitTestBehavior,
    this.overscroll,
  });
}
