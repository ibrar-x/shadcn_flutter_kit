// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror ChipInputThemeDefaults
// ═══════════════════════════════════════════════════════════

class ChipInputThemeTokens {
  const ChipInputThemeTokens({
    this.useChips = true,
    this.spacing = 4.0,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final bool useChips;
  final double spacing;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const chipInputThemeTokens = ChipInputThemeTokens();
