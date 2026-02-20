// ═══════════════════════════════════════════════════════════
// COMPONENT THEME DEFAULTS
// Built-in defaults (never changes)
// ═══════════════════════════════════════════════════════════

class MenuThemeDefaults {
  final Object? itemPadding;
  final Object? subMenuOffset;

  const MenuThemeDefaults({
    this.itemPadding = 'EdgeInsets.zero',
    this.subMenuOffset,
  });
}

class MenuPopupThemeDefaults {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? padding;
  final Object? fillColor;
  final Object? borderColor;
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
  final Object? border;
  final Object? subMenuOffset;
  final Object? padding;
  final Object? borderColor;
  final Object? backgroundColor;
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
