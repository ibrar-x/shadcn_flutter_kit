// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// ═══════════════════════════════════════════════════════════

class MenuThemeTokens {
  final Object? itemPadding;
  final Object? subMenuOffset;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const MenuThemeTokens({
    this.itemPadding,
    this.subMenuOffset,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const menuThemeTokens = MenuThemeTokens();

class MenuPopupThemeTokens {
  final Object? surfaceOpacity;
  final Object? surfaceBlur;
  final Object? padding;
  final Object? fillColor;
  final Object? borderColor;
  final Object? borderRadius;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const MenuPopupThemeTokens({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.padding,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const menuPopupThemeTokens = MenuPopupThemeTokens();

class MenubarThemeTokens {
  final Object? border;
  final Object? subMenuOffset;
  final Object? padding;
  final Object? borderColor;
  final Object? backgroundColor;
  final Object? borderRadius;
  final bool? ignoreGlobalScaling;
  final bool? ignoreGlobalRadius;

  const MenubarThemeTokens({
    this.border,
    this.subMenuOffset,
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
    this.ignoreGlobalScaling,
    this.ignoreGlobalRadius,
  });
}

const menubarThemeTokens = MenubarThemeTokens();
