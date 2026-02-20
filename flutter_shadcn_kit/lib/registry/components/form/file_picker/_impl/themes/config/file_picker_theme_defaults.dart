// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class FileUploadDropzoneThemeDefaults {
  /// Widget fallback: dropzoneTheme?.backgroundColor
  final Object? backgroundColor;

  /// Widget fallback: dropzoneTheme?.borderRadius
  final Object? borderRadius;

  /// Widget fallback: dropzoneTheme?.padding
  final Object? padding;

  /// Widget fallback: dropzoneTheme?.minHeight ?? 220 * scaling
  final Object? minHeight;
  final Object? icon;

  const FileUploadDropzoneThemeDefaults({
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.minHeight,
    this.icon,
  });
}
