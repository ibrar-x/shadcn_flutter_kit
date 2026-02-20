// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// Hard-coded widget/variant fallbacks are documented per field
// ═══════════════════════════════════════════════════════════

class MenuThemeDefaults {
  /// Widget fallback: compTheme?.itemPadding ?? EdgeInsets.zero
  final Object? itemPadding;

  /// Widget fallback: compTheme?.subMenuOffset
  final Object? subMenuOffset;

  const MenuThemeDefaults({this.itemPadding, this.subMenuOffset});
}

class MenuPopupThemeDefaults {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? padding;
  final Object? fillColor;

  /// Widget fallback: theme.colorScheme.border
  final Object? borderColor;

  /// Widget fallback: theme.borderRadiusMd
  final Object? borderRadius;

  const MenuPopupThemeDefaults({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
  });
}

class MenubarThemeDefaults {
  /// Widget fallback: widget.border
  final Object? border;

  /// Widget fallback: compTheme?.subMenuOffset
  final Object? subMenuOffset;
  final Object? padding;

  /// Widget fallback: theme.colorScheme.border
  final Object? borderColor;

  /// Widget fallback: theme.colorScheme.background
  final Object? backgroundColor;

  /// Widget fallback: theme.borderRadiusMd
  final Object? borderRadius;

  const MenubarThemeDefaults({
    this.border,
    this.subMenuOffset,
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
  });
}
