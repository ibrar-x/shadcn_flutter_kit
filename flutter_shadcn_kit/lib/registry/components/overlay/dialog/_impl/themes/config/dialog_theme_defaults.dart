// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class ModalBackdropThemeDefaults {
  final Object? borderRadius;
  final Object? padding;

  /// Widget fallback: const Color.fromRGBO(0
  final Object? barrierColor;
  final Object? modal;
  final Object? surfaceClip;

  const ModalBackdropThemeDefaults({
    this.borderRadius,
    this.padding,
    this.barrierColor,
    this.modal,
    this.surfaceClip,
  });
}
