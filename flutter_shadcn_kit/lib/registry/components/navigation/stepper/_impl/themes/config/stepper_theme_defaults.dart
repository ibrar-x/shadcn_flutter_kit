// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class StepperThemeDefaults {
  /// Widget fallback: compTheme?.direction ?? Axis.horizontal
  final Object? direction;

  /// Widget fallback: compTheme?.size ?? StepSize.medium
  final Object? size;

  /// Widget fallback: compTheme?.variant ?? StepVariant.circle
  final Object? variant;

  const StepperThemeDefaults({this.direction, this.size, this.variant});
}
