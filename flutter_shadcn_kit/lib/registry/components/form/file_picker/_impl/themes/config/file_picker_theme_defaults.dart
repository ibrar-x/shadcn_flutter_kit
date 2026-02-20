// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class FileUploadDropzoneThemeDefaults {
  final Object? backgroundColor;
  final Object? borderRadius;
  final Object? padding;
  final Object? minHeight;
  final Object? icon;

  const FileUploadDropzoneThemeDefaults({
    this.backgroundColor = 'theme.colorScheme.background',
    this.borderRadius,
    this.padding,
    this.minHeight = '220 * scaling',
    this.icon,
  });
}
