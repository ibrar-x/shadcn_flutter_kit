// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class ScrollableClientThemeTokens {
  final Object? diagonalDragBehavior;
  final Object? dragStartBehavior;
  final Object? keyboardDismissBehavior;
  final Object? clipBehavior;
  final Object? hitTestBehavior;
  final Object? overscroll;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const ScrollableClientThemeTokens({
    this.diagonalDragBehavior,
    this.dragStartBehavior,
    this.keyboardDismissBehavior,
    this.clipBehavior,
    this.hitTestBehavior,
    this.overscroll,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const scrollableClientThemeTokens = ScrollableClientThemeTokens();
