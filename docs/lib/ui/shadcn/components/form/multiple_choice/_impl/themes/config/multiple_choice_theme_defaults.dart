// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Extracted from hard-coded values in multiple choice widgets
// ═══════════════════════════════════════════════════════════

class MultipleChoiceThemeDefaults {
  const MultipleChoiceThemeDefaults({
    this.allowUnselect = false,
    this.multipleAnswerAllowUnselect = true,
  });

  /// From `_MultipleChoiceState`: `theme?.allowUnselect ?? false`
  final bool allowUnselect;

  /// From `_MultipleAnswerState`: `theme?.allowUnselect ?? true`
  final bool multipleAnswerAllowUnselect;
}
