// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror MultipleChoiceThemeDefaults
// ═══════════════════════════════════════════════════════════

class MultipleChoiceThemeTokens {
  const MultipleChoiceThemeTokens({
    this.allowUnselect = false,
    this.multipleAnswerAllowUnselect = true,
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final bool allowUnselect;
  final bool multipleAnswerAllowUnselect;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const multipleChoiceThemeTokens = MultipleChoiceThemeTokens();
