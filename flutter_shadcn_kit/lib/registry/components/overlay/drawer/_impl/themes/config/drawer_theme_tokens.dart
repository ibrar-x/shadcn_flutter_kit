// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class DrawerThemeTokens {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? barrierColor;
  final Object? showDragHandle;
  final Object? dragHandleSize;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const DrawerThemeTokens({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.showDragHandle,
    this.dragHandleSize,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const drawerThemeTokens = DrawerThemeTokens();
