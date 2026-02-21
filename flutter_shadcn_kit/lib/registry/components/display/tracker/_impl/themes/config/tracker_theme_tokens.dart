// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror TrackerThemeDefaults
// ═══════════════════════════════════════════════════════════

class TrackerThemeTokens {
  const TrackerThemeTokens({
    this.radius = 6.0,
    this.gap = 2.0,
    this.itemHeight = 32.0,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final double radius;
  final double gap;
  final double itemHeight;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const trackerThemeTokens = TrackerThemeTokens();
