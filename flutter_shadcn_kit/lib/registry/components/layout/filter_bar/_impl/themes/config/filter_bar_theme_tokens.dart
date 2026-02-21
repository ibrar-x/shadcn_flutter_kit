// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class FilterBarThemeTokens {
  const FilterBarThemeTokens({
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const filterBarThemeTokens = FilterBarThemeTokens();
