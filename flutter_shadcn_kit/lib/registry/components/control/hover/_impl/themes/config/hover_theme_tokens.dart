// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class HoverThemeTokens {
  final Object? debounceDuration;
  final Object? hitTestBehavior;
  final Object? waitDuration;
  final Object? minDuration;
  final Object? showDuration;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const HoverThemeTokens({
    this.debounceDuration,
    this.hitTestBehavior,
    this.waitDuration,
    this.minDuration,
    this.showDuration,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const hoverThemeTokens = HoverThemeTokens();
